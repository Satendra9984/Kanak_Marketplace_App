import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/models/gold_models/address_response.dart';

class DatastoreServices {
  static final _instance = Amplify.API;

  // _________________________________________________TRANSACTION OPERATIONS___________________________________________

  // add pending transaction
  static Future<Transaction?> addPendingTransaction(
      {required Transaction transaction}) async {
    Transaction? tx;
    final pendingTransactionMutation = ModelMutations.create(transaction);
    await _instance
        .mutate(request: pendingTransactionMutation)
        .response
        .then((pendingTx) async {
      if (pendingTx.data == null) {
        return;
      }
      tx = pendingTx.data!;
    });
    return tx;
  }

  // mark successful transaction
  static Future<Transaction?> markSuccessfulPurchase(
      {required Transaction transaction,
      required String gpTxId,
      required double balance,
      required String txId}) async {
    Transaction? result;
    final req = ModelMutations.update(transaction.copyWith(
      txId: txId,
      status: TransactionStatus.SUCCESSFUL,
      gpTxId: gpTxId,
      balance: balance,
      dateTime: TemporalDateTime.now(),
    ));
    await _instance.mutate(request: req).response.then((updatedTx) {
      if (updatedTx.data == null) {
        return;
      }
      result = updatedTx.data;
    });
    return result;
  }

  // get the next required details
  static Future<String?> checkRequiredData({required String uid}) async {
    String? nextRequiredDetails;
    final request = ModelQueries.get(User.classType, uid);
    await _instance.query(request: request).response.then((result) async {
      safePrint(result.data);
      if (result.data == null) {
        nextRequiredDetails = 'UserDetails';
        return;
      }
      await _instance
          .query(
              request: ModelQueries.list(Address.classType,
                  where: Address.USERID.eq(uid)))
          .response
          .then((address) async {
        safePrint(address.data?.items);
        if (address.data?.items == null ||
            address.data?.items.isEmpty == true) {
          nextRequiredDetails = 'Address';
          return;
        }
        await _instance
            .query(
                request: ModelQueries.list(BankAccount.classType,
                    where: BankAccount.USERID.eq(uid)))
            .response
            .then((acc) async {
          if (acc.data?.items == null || acc.data?.items.isEmpty == true) {
            nextRequiredDetails = 'BankAccount';
            return;
          }
          if (result.data?.kycDetails == null) {
            nextRequiredDetails = 'KycDetails';
            return;
          }
        });
      });
    });
    safePrint(nextRequiredDetails);
    return nextRequiredDetails;
  }

  // _________________________________________________FETCH OPERATION_____________________________________________________

  // fetch user details
  static Future<User?> fetchUserById(String id) async {
    User? fetchedUser;
    final request = ModelQueries.get(User.classType, id);
    await _instance.query(request: request).response.then((user) {
      if (user.data == null) {
        return;
      }
      fetchedUser = user.data;
    });
    // String getUser = 'getUser';
    // String graphQlDoc = '''query GetUser(\$id: ID!) {
    //   $getUser(id: \$id) {
    //     id
    //     wallet {
    //       id
    //     }
    //     address {
    //       items {
    //         id
    //       }
    //     }
    //     bankAccounts {
    //       items {
    //         id
    //       }
    //     }
    //   }
    // }''';
    // final getUserReq = GraphQLRequest<User>(
    //   document: graphQlDoc,
    //   modelType: User.classType,
    //   decodePath: getUser,
    //   variables: <String, String>{'id': id}
    // );
    // await Amplify.API.query(request: getUserReq).response.then((value) {
    //   safePrint('+++++> ${value.data}');
    // });
    return fetchedUser;
  }

  // fetch all addresses of user
  static Future<List<Address>> getAddressesOfUser(String userId) async {
    var list = <Address>[];
    _instance
        .query(
            request: ModelQueries.list(Address.classType,
                where: Address.USERID.eq(userId)))
        .response
        .then((addresses) {
      if (addresses.data == null || addresses.data!.items.isEmpty) {
        return;
      }
      for (var addr in addresses.data!.items) {
        list.add(addr!);
      }
    });
    return list;
  }

  // fetch all bank accounts of user
  static Future<List<BankAccount>> getBankAccountsOfUser(
      {required String userId}) async {
    var list = <BankAccount>[];
    _instance
        .query(
            request: ModelQueries.list(BankAccount.classType,
                where: BankAccount.USERID.eq(userId)))
        .response
        .then((accounts) {
      if (accounts.data == null || accounts.data!.items.isEmpty) {
        return;
      }
      for (var acc in accounts.data!.items) {
        list.add(acc!);
      }
    });
    return list;
  }

  // ________________________________________________CREATE AND UPDATE OPERATION___________________________________________

  // create user with wallet
  static Future<User?> createUserWithWallet(
      {required String email,
      required String phone,
      required String fname,
      required String lname,
      required String dob,
      required String userId}) async {
    User? createdUser;
    final wallet =
        Wallet(balance: 0, gold_balance: 0, address: '$phone@tasvat');
    final walletAddReq =
        _instance.mutate(request: ModelMutations.create(wallet));
    await walletAddReq.response.then((walRes) async {
      final user = User(
          id: userId,
          email: email,
          phone: phone,
          wallet: wallet,
          fname: fname,
          lname: lname,
          dob: TemporalDate.fromString(dob),
          userWalletId: wallet.id);
      final userAddReq = _instance.mutate(request: ModelMutations.create(user));
      await userAddReq.response.then((userRes) {
        if (userRes.data == null) {
          return;
        }
        createdUser = userRes.data;
      });
    });
    return createdUser;
  }

  // add address of user
  static Future<Address?> addUserAddress(
      {required UserAddressResponse rsp}) async {
    Address? createdAddr;
    final addr = Address(
        id: rsp.userAddressId,
        pincode: rsp.pincode,
        phone: rsp.mobileNumber,
        name: rsp.name,
        address: rsp.address,
        email: rsp.address,
        userID: rsp.userAccountId);
    final addressAddReq =
        _instance.mutate(request: ModelMutations.create(addr));
    await addressAddReq.response.then((value) {
      if (value.data == null) {
        return;
      }
      createdAddr = addr;
    });
    return createdAddr;
  }

  // add bank account of user
  static Future<BankAccount?> addBankAccount(
      {required BankAccount account}) async {
    BankAccount? createdAcc;
    final bankAccountReq =
        _instance.mutate(request: ModelMutations.create(account));
    await bankAccountReq.response.then((acc) {
      if (acc.data == null) {
        return;
      }
      createdAcc = acc.data;
    });
    return createdAcc;
  }

  // update KYC details of user
  static Future<User?> updateKycDetails(
      {required Map<String, dynamic> details, required User user}) async {
    final req =
        ModelMutations.update(user.copyWith(kycDetails: jsonEncode(details)));
    final res = await _instance.mutate(request: req).response;
    return res.data;
  }

  // upadate gold provider details of user
  static Future<User?> updateGPDetails(
      {required User user, required Map<String, dynamic> details}) async {
    final req = ModelMutations.update(
        user.copyWith(goldProviderDetails: jsonEncode(details)));
    final res = await _instance.mutate(request: req).response;
    return res.data;
  }
}
