import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/models/Token.dart' as tokenModel;
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
      {required Transaction transaction}) async {
    Transaction? result;
    await getTransactionVersion(txId: transaction.id).then((version) async {
      safePrint(version);
      safePrint(transaction.balance);
      safePrint(transaction.gpTxId);
      const String updateQuery = """
        mutation UpdateTransaction(\$id: ID!, \$status: TransactionStatus!, \$version: Int!, \$balance: Float!, \$gpTxId: String! ) {
          updateTransaction(input: {id: \$id, status: \$status, _version: \$version, gpTxId: \$gpTxId, balance: \$balance }) {
            id
            _version
            status
            gpTxId
            balance
          }
        }
      """;
      final variables = {
        "id": transaction.id,
        "status": "SUCCESSFUL",
        "gpTxId": transaction.gpTxId,
        "balance": transaction.balance,
        "version": version
      };
      try {
        final response = await _instance
            .mutate(
              request: GraphQLRequest<String>(
                document: updateQuery,
                variables: variables,
              ),
            )
            .response;
        if (response.data == null) {
          return;
        }
        result = transaction.copyWith(status: TransactionStatus.SUCCESSFUL);
        safePrint(result!.status);
      } catch (e) {
        safePrint('Update failed: $e');
      }
    });
    return result;
  }

  // mark failed transaction
  static Future<Transaction?> markFailedPurchase(
      {required Transaction transaction}) async {
    Transaction? result;
    await getTransactionVersion(txId: transaction.id).then((version) async {
      safePrint(version);
      const String updateQuery = """
        mutation UpdateTransaction(\$id: ID!, \$status: TransactionStatus!, \$version: Int!, \$type: FailType) {
          updateTransaction(input: {id: \$id, status: \$status, _version: \$version, failType: \$type}) {
            id
            failType
            _version
            status
          }
        }
      """;
      final variables = {
        "id": transaction.id,
        "status": "FAILED",
        "failType": "PURCHASEFAIL",
        "version": version
      };
      try {
        final response = await _instance
            .mutate(
              request: GraphQLRequest<String>(
                document: updateQuery,
                variables: variables,
              ),
            )
            .response;
        if (response.data == null) {
          return;
        }
        result = transaction.copyWith(
            status: TransactionStatus.FAILED, failType: FailType.PURCHASEFAIL);
        safePrint(result!.status);
      } catch (e) {
        safePrint('Update failed: $e');
      }
    });
    return result;
  }

  // mark failed payment
  static Future<Transaction?> markFailedPayment(
      {required Transaction transaction}) async {
    Transaction? result;
    await getTransactionVersion(txId: transaction.id).then((version) async {
      safePrint(version);
      const String updateQuery = """
        mutation UpdateTransaction(\$id: ID!, \$status: TransactionStatus!, \$version: Int!, \$type: FailType!) {
          updateTransaction(input: {id: \$id, status: \$status, _version: \$version, failType: \$type}) {
            id
            failType
            _version
            status
          }
        }
      """;
      final variables = {
        "id": transaction.id,
        "status": "FAILED",
        "failType": "PAYMENTFAIL",
        "version": version
      };
      try {
        final response = await _instance
            .mutate(
              request: GraphQLRequest<String>(
                document: updateQuery,
                variables: variables,
              ),
            )
            .response;
        if (response.data == null) {
          return;
        }
        result = transaction.copyWith(
            status: TransactionStatus.FAILED, failType: FailType.PAYMENTFAIL);
        safePrint(result!.status);
      } catch (e) {
        safePrint('Update failed: $e');
      }
    });
    return result;
  }

  // mark payment success
  static Future<Transaction?> markSuccessfulPayment(
      {required Transaction transaction, required String txId}) async {
    Transaction? result;
    await getTransactionVersion(txId: transaction.id).then((version) async {
      safePrint(version);
      const String updateQuery = """
        mutation UpdateTransaction(\$id: ID!, \$version: Int!, \$txId: String!) {
          updateTransaction(input: {id: \$id, _version: \$version, txId: \$txId}) {
            id
            txId
            _version
          }
        }
      """;
      final variables = {
        "id": transaction.id,
        "txId": txId,
        "version": version
      };
      try {
        final response = await _instance
            .mutate(
              request: GraphQLRequest<String>(
                document: updateQuery,
                variables: variables,
              ),
            )
            .response;
        if (response.data == null) {
          return;
        }
        result = transaction.copyWith(failType: FailType.PURCHASEFAIL);
        safePrint(result!.status);
      } catch (e) {
        safePrint('Update failed: $e');
      }
    });
    return result;
  }

  // update wallet gold balance
  static Future<Wallet?> updateWalletGoldBalance(
      {required Wallet wallet, required double balance}) async {
    Wallet? result;
    await getWalletVersion(id: wallet.id).then((version) async {
      safePrint(version);
      const String updateQuery = """
        mutation UpdateWallet(\$id: ID!, \$version: Int!, \$balance: Float! ) {
          updateWallet(input: {id: \$id, _version: \$version, balance: \$balance }) {
            id
            _version
            balance
          }
        }
      """;
      final variables = {
        "id": wallet.id,
        "balance": balance,
        "version": version
      };
      try {
        final response = await _instance
            .mutate(
              request: GraphQLRequest<String>(
                document: updateQuery,
                variables: variables,
              ),
            )
            .response;
        if (response.data == null) {
          return;
        }
        result = wallet.copyWith(gold_balance: balance);
        safePrint(result!.balance);
      } catch (e) {
        safePrint('Update failed: $e');
      }
    });
    return result;
  }

  // mark wallet update fail
  static Future<Transaction?> markWalletUpdateFail(
      {required Transaction transaction}) async {
    Transaction? result;
    final req = ModelMutations.update(transaction.copyWith(
        status: TransactionStatus.FAILED, failType: FailType.WALLETUPDATEFAIL));
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

  static Future<int?> getUserVersion({required String userId}) async {
    int? version;
    const String getUserQuery = """
      query GetUser(\$id: ID!) {
        getUser(id: \$id) {
          _version
        }
      }
    """;
    try {
      final response = await _instance
          .query(
            request: GraphQLRequest<String>(
              document: getUserQuery,
              variables: {'id': userId},
            ),
          )
          .response;
      version = jsonDecode(response.data!)['getUser']['_version'];
    } catch (e) {
      safePrint('Failed to retrieve user record: $e');
    }
    return version;
  }

  static Future<int?> getTransactionVersion({required String txId}) async {
    int? version;
    const String getTxQuery = """
      query GetTransaction(\$id: ID!) {
        getTransaction(id: \$id) {
          _version
        }
      }
    """;
    try {
      final response = await _instance
          .query(
            request: GraphQLRequest<String>(
              document: getTxQuery,
              variables: {'id': txId},
            ),
          )
          .response;
      version = jsonDecode(response.data!)['getTransaction']['_version'];
    } catch (e) {
      safePrint('Failed to retrieve user record: $e');
    }
    return version;
  }

  static Future<int?> getBankAccountVersion({required String bankId}) async {
    int? version;
    const String getUserQuery = """
      query GetBankAccount(\$id: ID!) {
        getBankAccount(id: \$id) {
          _version
        }
      }
    """;
    try {
      final response = await _instance
          .query(
            request: GraphQLRequest<String>(
              document: getUserQuery,
              variables: {'id': bankId},
            ),
          )
          .response;
      version = jsonDecode(response.data!)['getBankAccount']['_version'];
    } catch (e) {
      safePrint('Failed to retrieve user record: $e');
    }
    return version;
  }

  static Future<int?> getAddressVersion({required String addressId}) async {
    int? version;
    const String getUserQuery = """
      query GetAddress(\$id: ID!) {
        getAddress(id: \$id) {
          _version
        }
      }
    """;
    try {
      final response = await _instance
          .query(
            request: GraphQLRequest<String>(
              document: getUserQuery,
              variables: {'id': addressId},
            ),
          )
          .response;
      version = jsonDecode(response.data!)['getAddress']['_version'];
    } catch (e) {
      safePrint('Failed to retrieve user record: $e');
    }
    return version;
  }

  static Future<int?> getWalletVersion({required String id}) async {
    int? version;
    const String getTxQuery = """
      query GetWallet(\$id: ID!) {
        getWallet(id: \$id) {
          _version
        }
      }
    """;
    try {
      final response = await _instance
          .query(
            request: GraphQLRequest<String>(
              document: getTxQuery,
              variables: {'id': id},
            ),
          )
          .response;
      version = jsonDecode(response.data!)['getWallet']['_version'];
    } catch (e) {
      safePrint('Failed to retrieve user record: $e');
    }
    return version;
  }

  // fetch full user details
  static Future<User?> fetchUserById(String id) async {
    User? fetchedUser;
    final request = ModelQueries.get(User.classType, id);
    await _instance.query(request: request).response.then((user) async {
      if (user.data == null) {
        return;
      }
      fetchedUser = user.data;
      final req = ModelQueries.list(BankAccount.classType,
          where: BankAccount.USERID.eq(id));

      await _instance.query(request: req).response.then((banks) async {
        if (banks.data == null) {
          return;
        }
        if (banks.data?.items != null && banks.data?.items.isNotEmpty == true) {
          List<BankAccount> bankList =
              banks.data!.items.map((e) => e!).toList();
          fetchedUser = user.data!.copyWith(bankAccounts: bankList);
          debugPrint(
              '---------------- banks from datastore\n ${fetchedUser?.bankAccounts?.length}');
        }
        final req =
            ModelQueries.list(Address.classType, where: Address.USERID.eq(id));
        await _instance.query(request: req).response.then((addrs) async {
          if (addrs.data == null) {
            return;
          }
          if (addrs.data?.items != null &&
              addrs.data?.items.isNotEmpty == true) {
            List<Address> addrsList = addrs.data!.items.map((e) => e!).toList();
            fetchedUser = user.data!.copyWith(address: addrsList);
          }
          final req =
              ModelQueries.get(Wallet.classType, user.data!.userWalletId!);
          await _instance.query(request: req).response.then((wallet) {
            if (wallet.data == null) {
              return;
            }
            fetchedUser = user.data!.copyWith(wallet: wallet.data);
          });
        });
      });
    });

    safePrint(fetchedUser?.address?.length.toString());

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

  // fetch token for app
  static Future<tokenModel.Token?> getToken() async {
    tokenModel.Token? result;
    final req = ModelQueries.get(
        tokenModel.Token.classType, "ce0878d1-0da3-4e5a-a4bd-d33830165229");
    await _instance.query(request: req).response.then((tokenRes) {
      safePrint(tokenRes);
      if (tokenRes.data == null) {
        return;
      }
      result = tokenRes.data;
    });
    return result;
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
      {required UserAddressResponse rsp, required String userId}) async {
    Address? createdAddr;
    final addr = Address(
        id: rsp.userAddressId,
        pincode: rsp.pincode,
        phone: '+91${rsp.mobileNumber}',
        name: rsp.name,
        address: rsp.address,
        email: rsp.email,
        userID: userId);
    final addressAddReq =
        _instance.mutate(request: ModelMutations.create(addr));
    await addressAddReq.response.then((value) {
      safePrint(value.data?.toJson());
      if (value.data == null) {
        return;
      }
      createdAddr = value.data;
    }).catchError((err) {
      safePrint(err.toString());
    });
    return createdAddr;
  }

  // add bank account of user
  static Future<BankAccount?> addBankAccount(
      {required BankAccount account}) async {
    BankAccount? createdAcc;
    safePrint(account);
    final bankAccountReq =
        _instance.mutate(request: ModelMutations.create(account));
    await bankAccountReq.response.then((acc) {
      safePrint(acc);
      if (acc.data == null) {
        return;
      }
      createdAcc = acc.data;
    });
    return createdAcc;
  }

  // set default bank id
  static Future<User?> updateDefaultBankId(
      {required User user, required String bankId}) async {
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
    await getUserVersion(userId: user.id).then((version) async {
      safePrint(version);
      const String updateQuery = """
        mutation UpdateUser(\$id: ID!, \$kycDetails: String!, \$version: Int!) {
          updateUser(input: {id: \$id, kycDetails: \$kycDetails, _version: \$version}) {
            id
            _version
            kycDetails
          }
        }
      """;
      final variables = {
        "id": user.id,
        "kycDetails": jsonEncode(details),
        "version": version
      };
      try {
        final response = await _instance
            .mutate(
              request: GraphQLRequest<String>(
                document: updateQuery,
                variables: variables,
              ),
            )
            .response;
        if (response.data == null) {
          return;
        }
        result = user.copyWith(
            kycDetails: jsonDecode(response.data!)['updateUser']['kycDetails']);
        safePrint(result!.kycDetails);
      } catch (e) {
        safePrint('Update failed: $e');
      }
    });
    return result;
  }

  // upadate gold provider details of user
  static Future<User?> updateGPDetails(
      {required User user, required Map<String, dynamic> details}) async {
    User? result;
    await getUserVersion(userId: user.id).then((version) async {
      safePrint(version);
      const String updateQuery = """
        mutation UpdateUser(\$id: ID!, \$goldProviderDetails: String!, \$version: Int!) {
          updateUser(input: {id: \$id, goldProviderDetails: \$goldProviderDetails, _version: \$version}) {
            id
            _version
            goldProviderDetails
          }
        }
      """;
      final variables = {
        "id": user.id,
        "goldProviderDetails": jsonEncode(details),
        "version": version
      };
      try {
        final response = await _instance
            .mutate(
              request: GraphQLRequest<String>(
                document: updateQuery,
                variables: variables,
              ),
            )
            .response;
        if (response.data == null) {
          return;
        }
        result = user.copyWith(
            goldProviderDetails: jsonDecode(response.data!)['updateUser']
                ['goldProviderDetails']);
        safePrint(result!.goldProviderDetails);
      } catch (e) {
        safePrint('Update failed: $e');
      }
    });
    return result;
  }

  // update particular address
  static Future<Address?> updateAddress({required Address addr}) async {
    Address? result;

    await getAddressVersion(addressId: addr.id).then((version) async {
      safePrint(version);
      const String updateQuery = """
        mutation UpdateAddress(\$id: ID!, \$address: String!, \$pincode: Int!, \$name: String!, \$phone: AWSPhone!, \$email: AWSEmail!, \$status: Boolean!, \$version: Int!) {
          updateAddress(input: {id: \$id, name: \$name, address: \$address, pincode: \$pincode, phone: \$phone, email: \$email, status: \$status, _version: \$version, }) {
            id
            address
            status
            name
            pincode
            phone
            email
            _version
          }
        }
      """;
      final variables = {
        "id": addr.id,
        "address": addr.address,
        "status": addr.status,
        "email": addr.email,
        "phone": addr.phone,
        "pincode": addr.pincode,
        "name": addr.name,
        "version": version
      };
      // try {
      final response = await _instance
          .mutate(
            request: GraphQLRequest<String>(
              document: updateQuery,
              variables: variables,
            ),
          )
          .response;
      if (response.data == null) {
        return;
      }
      result = addr;
      safePrint(result);
      // } catch (e) {
      //   safePrint('Update failed: $e');
      // }
    });
    return result;
  }

  // update bank account
  static Future<BankAccount?> updateBankAccount(
      {required BankAccount bankAccount}) async {
    BankAccount? result;

    await getBankAccountVersion(bankId: bankAccount.id).then((version) async {
      safePrint(version);
      const String updateQuery = """
        mutation UpdateBankAccount(\$id: ID!, \$bankId: String!, \$accNo: String!, \$ifsc: String!, \$addressId: String!, \$accName: String!,\$status: Boolean!, \$version: Int!) {
          updateBankAccount(input: {id: \$id, bankId: \$bankId, accNo: \$accNo, ifsc: \$ifsc, addressId: \$addressId,accName: \$accName,status:\$status, _version: \$version, }) {
            id
            bankId
            accNo
            ifsc
            addressId
            accName
            userId
            status
            _version
          }
        }
      """;
      final variables = {
        "id": bankAccount.id,
        "bankId": bankAccount.bankId,
        "accNo": bankAccount.accName,
        "ifsc": bankAccount.ifsc,
        "addressId": bankAccount.addressId,
        "accName": bankAccount.accName,
        "userId": bankAccount.userID,
        "status": bankAccount.status,
        "version": version
      };
      final response = await _instance
          .mutate(
            request: GraphQLRequest<String>(
              document: updateQuery,
              variables: variables,
            ),
          )
          .response;
      if (response.data == null) {
        return;
      }
      result = bankAccount;
      safePrint(result);
    });
    return result;
  }

  /// <---------------------------------------- Delete ----------------------------------->

  static Future<bool> deleteUserBank({required BankAccount bankAccount}) async {
    final request = ModelMutations.delete(bankAccount);
    final response = await Amplify.API.mutate(request: request).response;
    // print('Response: $response');

    if (response.data != null) {
      return true;
    }
    return false;
  }
}
