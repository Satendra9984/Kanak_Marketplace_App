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
    print(nextRequiredDetails);
    return nextRequiredDetails;
  }
}