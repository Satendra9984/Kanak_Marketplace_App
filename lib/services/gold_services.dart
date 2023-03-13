import 'package:flutter/foundation.dart';
import 'package:tasvat/services/local_db_services.dart';
import 'package:tasvat/services/rest_services.dart';

class GoldServices {
  static const String _baseUrl = 'https://uat-api.augmont.com/api/merchant/v1/';

  // get log in session credentials
  Future<void> sessionLogIn() async {
    await HttpServices.sendPostReq('${_baseUrl}auth/login', body: {
      'email': 'subhadeepchodhury41@gmail.com',
      'password': '_K/PT_E~X_3[%AS1'
    }).then((value) async {
      if (value == null) {
        return;
      }
      if (value['statusCode'] == 200) {
        await LocalDBServices.storeGPAccessToken(value['result']['data']['accessToken']);
        await LocalDBServices.storeGPMerchantId(value['result']['data']['merchantId']);
        await LocalDBServices.storeGPTokenExpiry(value['result']['data']['expiresAt']);
      }
    }).catchError((err) {
      debugPrint(err.toString());
    });
  }

  // create user
}