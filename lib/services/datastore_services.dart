import 'dart:convert';
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
  static Future<Transaction?> markSuccessfulPurchase({
    required Transaction transaction
  }) async {
    Transaction? result;
    final req = ModelMutations.update(transaction.copyWith(
      status: TransactionStatus.SUCCESSFUL,
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

  // mark failed transaction
  static Future<Transaction?> markFailedPurchase({
    required Transaction transaction
  }) async {
    Transaction? result;
    final req = ModelMutations.update(transaction.copyWith(
      status: TransactionStatus.FAILED,
      txId: transaction.txId,
      failType: FailType.PURCHASEFAIL
    ));
    await _instance.mutate(request: req).response.then((res) {
      if (res.data == null) {
        return;
      }
      result = res.data;
    });
    return result;
  }

  // mark failed payment
  static Future<Transaction?> markFailedPayment({
    required Transaction transaction
  }) async {
    Transaction? result;
    final req = ModelMutations.update(transaction.copyWith(
      status: TransactionStatus.FAILED,
      failType: FailType.PAYMENTFAIL
    ));
    await _instance.mutate(request: req).response.then((res) {
      if (res.data == null) {
        return;
      }
      result = res.data;
    });
    return result;
  }

  // mark payment success
  static Future<Transaction?> markSuccessfulPayment({
    required Transaction transaction,
    required String txId
  }) async {
    Transaction? result;
    final req = ModelMutations.update(transaction.copyWith(
      txId: txId
    ));
    await _instance.mutate(request: req).response.then((res) {
      if (res.data == null) {
        return;
      }
      result = res.data;
    });
    return result;
  }
  
  // update wallet gold balance
  static Future<Wallet?> updateWalletGoldBalance({
    required String id,
    required double balance
  }) async {
    Wallet? result;
    _instance.query(request: ModelQueries.get(Wallet.classType, id)).response.then((wallet) async {
      if (wallet.data == null) {
        return;
      }
      final req = ModelMutations.update(wallet.data!.copyWith(
        gold_balance: balance
      ));
      await _instance.mutate(request: req).response.then((res) {
        if (res.data == null) {
          return;
        }
        result = res.data;
      });
    });
    return result;
  }

  // mark wallet update fail
  static Future<Transaction?> markWalletUpdateFail({
    required Transaction transaction
  }) async {
    Transaction? result;
    final req = ModelMutations.update(transaction.copyWith(
      status: TransactionStatus.FAILED,
      failType: FailType.WALLETUPDATEFAIL
    ));
    await _instance.mutate(request: req).response.then((res) {
      if (res.data == null) {
        return;
      }
      result = res.data;
    });
    return result;
  }

  
  
  
  
  
  
  
  
  // _________________________________________________SPECIAL CHECKS OPERATION_____________________________________________________

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

  // fetch full user details
  static Future<User?> fetchUserById(String id) async {
    User? fetchedUser;
    final request = ModelQueries.get(User.classType, id);
    await _instance.query(request: request).response.then((user) async {
      if (user.data == null) {
        return;
      }
      fetchedUser = user.data;
      final req = ModelQueries.list(
        BankAccount.classType, where: BankAccount.USERID.eq(id)
      );
      await _instance.query(request: req).response.then((banks) async {
        if (banks.data == null) {
          return;
        }
        if (banks.data?.items != null && banks.data?.items.isNotEmpty == true) {
          List<BankAccount> bankList = banks.data!.items.map((e) => e!).toList();
          fetchedUser = user.data!.copyWith(bankAccounts: bankList);
        }
        final req = ModelQueries.list(
          Address.classType, where: Address.USERID.eq(id)
        );
        await _instance.query(request: req).response.then((addrs) {
          if (addrs.data == null) {
            return;
          }
          if (addrs.data?.items != null && addrs.data?.items.isNotEmpty == true) {
            List<Address> addrsList = addrs.data!.items.map((e) => e!).toList();
            fetchedUser = user.data!.copyWith(address: addrsList);
          }
        });
      });
    });

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

  static Future<void> testApi() async {
    final req = ModelMutations.create(Wallet(
      address: 'test@tasvat',
      balance: 20000,
      gold_balance: 20
    ));
    await _instance.mutate(request: req).response.then((value) {
      if (value.data == null) {
        safePrint('Error');
        return;
      }
      safePrint(value.data?.toJson());
    });
  }

  // set default bank id
  static Future<User?> updateDefaultBankId({
    required User user,
    required String bankId
  }) async {
    User? updatedUser;
    final req = ModelMutations.update(user.copyWith(defaultBankId: bankId));
    await _instance.mutate(request: req).response.then((value) {
      if (value.data == null) {
        return;
      }
      updatedUser = value.data;
    });
    return updatedUser;
  }

  // update KYC details of user
  static Future<User?> updateKycDetails(
      {required Map<String, dynamic> details, required User user}) async {
    User? result;
    final req = ModelMutations.update(
        user.copyWith(kycDetails: jsonEncode(details)));
    await _instance.mutate(request: req).response.then((res) {
      if (res.data == null) {
        return;
      }
      result = res.data;
    });
    return result;
  }

  // upadate gold provider details of user
  static Future<User?> updateGPDetails(
      {required User user, required Map<String, dynamic> details}) async {
    User? result;
    final req = ModelMutations.update(
        user.copyWith(goldProviderDetails: jsonEncode(details)));
    await _instance.mutate(request: req).response.then((res) {
      if (res.data == null) {
        return;
      }
      result = res.data;
    });
    return result;
  }

  // update particular address
  static Future<Address?> updateAddress({
    required Address addr
  }) async {
    Address? result;
    final req = ModelMutations.update(addr);
    await _instance.mutate(request: req).response.then((value) {
      if (value.data == null) {
        return;
      }
      result = value.data;
    });
    return result;
  }
}
