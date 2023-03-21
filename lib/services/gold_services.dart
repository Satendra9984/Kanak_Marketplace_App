import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/models/gold_models/address_response.dart';
import 'package:tasvat/models/gold_models/buy_info_model.dart';
import 'package:tasvat/models/gold_models/rate_model.dart';
import 'package:tasvat/models/gold_models/sell_info_model.dart';
import 'package:tasvat/services/datastore_services.dart';
import 'package:tasvat/services/local_db_services.dart';
import 'package:tasvat/services/rest_services.dart';

class GoldServices {
  static const String _baseUrl =
      'https://uat-api.augmontgold.com/api/merchant/v1/';

  static Future<List<Map<dynamic, dynamic>>> getStateCityList(
      String name) async {
    List<Map<String, dynamic>> list = [];
    try {
      String? token = await LocalDBServices.getGPAccessToken();
      // debugPrint(token.toString());
      if (token == null) {
        return list;
      }
      token =
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiZWU2OTY3NjY2MmQzYWYxMjUyNzZiZTJhNTE1ZWYyY2VjOWFlYzlhMzllN2E1MmM1Mjc1Nzc0OTNlMzQ0MThkMDdhZGY5ODdjZGFjYWVjYzQiLCJpYXQiOjE2NzkzOTU5MzgsIm5iZiI6MTY3OTM5NTkzOCwiZXhwIjoxNjgxOTg3OTM4LCJzdWIiOiI1MDAwMDk0MyIsInNjb3BlcyI6W119.WZHxS4Oor7uYjcZ1RARNRvGYyfYbxK7LfxGZc-StoPiis2YcgC0gvfBTCFWq8Efj4gQrjFCDKI5gM7zjRAH7nm2MO1sRLLJF7uM1xPjSunRQncr2mnqOYJNoQaR_rOAB7r9k2_eC8S9zDMghrJtr3MJDJNT2XccrwiFI8r6W0Wl0GhmbhBlWmnyk3oJARb05o6crwScJxfVxDaOmeeMpK2BxYckbFGnERQRh_PhFpJBdrO-Ha3-BmNl5Xc540zxZ9FwKLcuXOS3AqnwkWKJDXpJ1hRR5017eTfCzP6oVtKk87XoP-Kppd0Mi0gMtwheba68RPcZuONyWhOVryqQ48u-PkDl1ffgYcEGcDNjkQhwzDmGBu-SoNbw7BNFpD9zTwpv3EU_DK2f1p-5BDHNsWY2U-_XFl5krLLRaaB3RXCJaj09t5cVIlrIV9OfpImahbC2U4FfdcePnT-QuYMUqojUmbsB9sYs8niKbrr2lQtuBgk5d_Dj4ZnCUBWbcI5-hY84cAREVYWvr5BHmhlcAqfEBTWwKMtgUDQHjvKH_Tif17ffwr6oGB0ruEcjZ67-khI37p8b2Mi8uXQ803broRpYhA0ZmtTS9MkN-MkJDLO0l0a8GMIObC7KlRfzOU1WRq-HO36ijhj8bG5BpWdYsvn1uO2TreUya2RTWKaWh1x0';
      dynamic result = await HttpServices.sendGetReq(
          '${_baseUrl}master/states?count=50',
          extraHeaders: {'Authorization': 'Bearer $token'});
      debugPrint(result.toString());
      if (result != null) {
        list = result['result']['data'];
      }
    } catch (e) {
      return list;
    }
    return list;
  }

  // get log in session credentials
  static Future<bool> sessionLogIn() async {
    bool success = false;
    await HttpServices.sendPostReq('${_baseUrl}auth/login', body: {
      'email': 'subhadeepchowdhury41@gmail.com',
      'password': '_K/PT_E~X_3[%AS1'
    }).then((value) async {
      if (value == null) {
        return;
      }
      safePrint(value);
      if (value['statusCode'] == 200) {
        await LocalDBServices.storeGPAccessToken(
            value['result']['data']['accessToken']);
        await LocalDBServices.storeGPMerchantId(
            value['result']['data']['merchantId']);
        await LocalDBServices.storeGPTokenExpiry(
            value['result']['data']['expiresAt']);
        success = true;
      }
    }).catchError((err) {
      debugPrint(err.toString());
    });
    return success;
  }

  // create user
  static Future<Map<String, dynamic>?> registerGoldUser(
      {required String phone,
      required String email,
      required String userId,
      required String name,
      required String pincode,
      required String dob}) async {
    Map<String, dynamic>? details;
    final authToken = await LocalDBServices.getGPAccessToken();
    await HttpServices.sendPostReq('${_baseUrl}users', extraHeaders: {
      'Authorization': 'Bearer $authToken'
    }, body: {
      'mobileNumber': phone,
      'emailId': email,
      'uniqueId': userId,
      'userName': name,
      'userPincode': pincode,
      'dateOfBirth': dob
    }).then((value) {
      if (value == null || !value.containsKey('statusCode')) {
        return;
      }
      if (value['statusCode'] == 201) {
        details = value['result'];
      }
    });
    return details;
  }

  // buy gold
  static Future<BuyInfo?> buyGold(
      {required User user,
      required Transaction transaction,
      required ExchangeRates rates}) async {
    BuyInfo? info;
    final authToken = await LocalDBServices.getGPAccessToken();
    await HttpServices.sendPostReq('${_baseUrl}buy', body: {
      'lockPrice': int.parse(rates.gBuy!),
      'metalType': 'gold',
      'quantity': transaction.amount,
      'merchantTransactionId': transaction.id,
      'userName': user.fname! + user.lname!,
      'uniqueId': transaction.id,
      'blockId': rates.blockId,
      'mobileNumber': user.phone,
      'emailId': user.email
    }, extraHeaders: {
      'Authorization': 'Bearer $authToken'
    }).then((res) {
      if (res == null) {
        return;
      }
      if (res.containsKey('statusCode') && res['statusCode'] == 200) {
        info = BuyInfo.fromJson(res['result']['data']);
      }
    });
    return info;
  }

  // sell gold
  static Future<SellInfo?> sellGold(
      {required User user,
      required String bankId,
      required Transaction transaction,
      required ExchangeRates rate}) async {
    SellInfo? info;
    final authToken = await LocalDBServices.getGPAccessToken();
    await HttpServices.sendPostReq('sell', body: {
      'uniqueId': user.id,
      'mobileNumber': user.phone,
      'lockPrice': int.parse(rate.gSell!),
      'blockId': rate.blockId,
      'metalType': 'gold',
      'quantity': transaction.amount,
      'merchantTransactionId': transaction.id,
      'bankId': bankId
    }, extraHeaders: {
      'Authorization': 'Bearer $authToken'
    }).then((res) {
      if (res == null) {
        return;
      }
      if (!res.containsKey('statusCode') || res['statusCode'] != 200) {
        info = SellInfo.fromJson(res['result']['data']);
      }
    });
    return info;
  }

  // get gold rate
  static Future<ExchangeRates?> getMetalsRate() async {
    ExchangeRates? rates;
    await HttpServices.sendGetReq('${_baseUrl}rates').then((result) {
      if (result == null) {
        return;
      }
      if (!result.containsKey('statusCode')) {
        return;
      }
      if (result['statusCode'] == 200) {
        rates = ExchangeRates.fromJson(result['result']['data']);
      }
    });
    return rates;
  }

  // add user address
  static Future<UserAddressResponse?> addGoldUserAddress({
    required User user,
    required String name,
    String? phone,
    required String address,
    required int pincode,
    String? email,
    required String state,
    required String city,
  }) async {
    UserAddressResponse? rsp;
    await HttpServices.sendPostReq('users/${user.id}/address', body: {
      'name': name,
      'mobileNumber': phone ?? user.phone!.substring(3),
      'address': address,
      'pincode': pincode,
      'email': email ?? user.email,
      'state': state,
      'city': city
    }).then((addr) async {
      if (addr == null) {
        return;
      }
      if (!addr.containsKey('statusCode') || addr['statusCode'] != 200) {
        return;
      }
      rsp = UserAddressResponse.fromJson(addr['result']['data']);
    });
    return rsp;
  }
}
