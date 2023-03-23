import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/models/gold_models/address_response.dart';
import 'package:tasvat/models/gold_models/buy_info_model.dart';
import 'package:tasvat/models/gold_models/rate_model.dart';
import 'package:tasvat/models/gold_models/sell_info_model.dart';
import 'package:tasvat/services/local_db_services.dart';
import 'package:tasvat/services/rest_services.dart';

class GoldServices {
  static const String _baseUrl =
      'https://uat-api.augmontgold.com/api/merchant/v1/';

  static Future<List<dynamic>> getStateCityList() async {
    List<dynamic> list = [];
    try {
      String? token = await LocalDBServices.getGPAccessToken();
      if (token == null) {
        safePrint('No token');
        return const [];
      }
      await HttpServices.sendGetReq(
          '${_baseUrl}master/states?count=50',
          extraHeaders: {'Authorization': 'Bearer $token'}).then((result) {
            debugPrint(result.toString());
            if (result != null) {
              list = result['result']['data'];
            }
          });
      
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
    return list;
  }

  static Future<List<dynamic>> getCityList(String state) async {
    List<dynamic> list = [];
    try {
      String? token = await LocalDBServices.getGPAccessToken();
      if (token == null) {
        return list;
      }
      await HttpServices.sendGetReq(
          '${_baseUrl}master/cities?stateId=$state&count=400&page=1',
          extraHeaders: {'Authorization': 'Bearer $token'}).then((result) {
            if (result != null) {
              list = result['result']['data'];
            }
          });
    } catch (e) {
      debugPrint(e.toString());
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
      required String city,
      required String dob
    }) async {
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
      'userCity': city,
      'dateOfBirth': dob
    }).then((value) {
      if (value == null || !value.containsKey('statusCode')) {
        return;
      }
      if (value['statusCode'] == 201) {
        details = value['result']['data'];
      }
    });
    return details;
  }

  // buy gold
  static Future<BuyInfo?> buyGold({
      required User user,
      required Transaction transaction,
      required ExchangeRates rates
    }) async {
    BuyInfo? info;
    final authToken = await LocalDBServices.getGPAccessToken();
    await HttpServices.sendPostReq('${_baseUrl}buy', body: {
      'lockPrice': int.parse(rates.gBuy!), // number
      'metalType': 'gold', // string
      'quantity': transaction.quantity, //
      'merchantTransactionId': transaction.txId,
      'userName': "${user.fname!} ${user.lname!}",
      'uniqueId': user.id,
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
