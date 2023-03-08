import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:tasvat/models/ModelProvider.dart';

class DatastoreServices {
  static final _instance = Amplify.API;
  static Future<String?> checkRequiredData(String uid) async {
    String? nextRequiredDetails;
    final request = ModelQueries.get(User.classType, uid);
    await _instance.query(request: request).response.then((result) {
      if (result.data == null) {
        nextRequiredDetails = 'UserDetails';
        return;
      }
      if (result.data?.address == null ||
       result.data?.address?.isEmpty == true) {
        nextRequiredDetails = 'Address';
        return;
      }
      if (result.data?.kycDetails == null) {
        nextRequiredDetails = 'KycDetails';
      }
      if (result.data?.bankAccounts == null ||
       result.data?.bankAccounts?.isEmpty == true) {
        nextRequiredDetails = 'BankAccount';
      }
    });
    safePrint(nextRequiredDetails);
    return nextRequiredDetails;
  }

  static Future<User?> addUserDetails({
    required String email,
    required String phone,
    required String fname,
    required String lname,
    required int pincode,
    required String dob,
    required String userId
  }) async {
    User? createdUser;
    final wallet = Wallet(
      balance: 0,
      gold_balance: 0,
      address: '$phone@tasvat'
    );
    final walletAddReq = _instance.mutate(request: ModelMutations.create(wallet));
    await walletAddReq.response.then((walRes) async {
      final user = User(
        id: userId,
        email: email,
        phone: phone,
        pincode: pincode,
        wallet: wallet,
        fname: fname,
        lname: lname,
        dob: TemporalDate.fromString(dob)
      );
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
}