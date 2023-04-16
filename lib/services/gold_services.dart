import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/models/gold_models/address_response.dart';
import 'package:tasvat/models/gold_models/bank_response.dart';
import 'package:tasvat/models/gold_models/buy_info_model.dart';
import 'package:tasvat/models/gold_models/rate_model.dart';
import 'package:tasvat/models/gold_models/sell_info_model.dart';
import 'package:tasvat/services/local_db_services.dart';
import 'package:tasvat/services/rest_services.dart';
import 'package:tasvat/utils/loggs.dart';

class GoldServices {
  static const String _baseUrl =
      'https://uat-api.augmontgold.com/api/merchant/v1/';

  static Future<Map<String, dynamic>?> getUserDetails(
      {required String userId}) async {
    Map<String, dynamic>? detailsMap;

    String? token = await LocalDBServices.getGPAccessToken();
    if (token == null) {
      return null;
    }
    await HttpServices.sendGetReq('${_baseUrl}users/$userId', extraHeaders: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    }).then((response) {
      if (response == null || response['statusCode'] != 200) {
        return null;
      }
      // debugPrint(
      //     'getdata\n: $response, \ntype: ${response['result']['data'].runtimeType}');
      // debugPrint(response['result']['data'].toString());
      detailsMap = response['result']['data'] as Map<String, dynamic>;
    });

    // detailsMap = {
    //   "statusCode": 200,
    //   "message": "User details retrieved successfully.",
    //   "result": {
    //     "data": {
    //       "userName": "Vikrant Lad",
    //       "dateOfBirth": "1994-01-24",
    //       "gender": null,
    //       "userEmail": "vikrant@gmail.com",
    //       "userAddress": "Sej Plaze, Malad West",
    //       "userStateId": "qYMjvMvX",
    //       "userCityId": "z6KkbrMb",
    //       "userPincode": "401105",
    //       "nomineeName": "Vishal",
    //       "nomineeRelation": "Brother",
    //       "nomineeDateOfBirth": "2001-02-11",
    //       "kycStatus": "Pending",
    //       "userState": "Maharashtra",
    //       "userCity": "Mumbai City"
    //     }
    //   }
    // };
    return detailsMap;
  }

  static Future<List<dynamic>> getStateCityList() async {
    List<dynamic> list = [];
    try {
      String? token = await LocalDBServices.getGPAccessToken();
      if (token == null) {
        safePrint('No token');
        return const [];
      }
      debugPrint(token);
      await HttpServices.sendGetReq('${_baseUrl}master/states?count=50',
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

  // get user bank accounts
  static Future<List<UserBank>> getUserBankAccounts(
      {required String userId}) async {
    List<UserBank> result = [];
    final authToken = await LocalDBServices.getGPAccessToken();
    await HttpServices.sendGetReq('${_baseUrl}users/$userId/banks',
        extraHeaders: {'Authorization': 'Bearer $authToken'}).then((banksRes) {
      if (banksRes == null) {
        return;
      }
      if (!banksRes.containsKey('statusCode') ||
          banksRes['statusCode'] != 200) {
        return;
      }
      final bankList = banksRes['result'];
      for (var bank in bankList) {
        result.add(UserBank.fromJson(bank as Map<String, dynamic>));
      }
      safePrint(bankList.length);
    });
    return result;
  }

  // create user account
  static Future<Map<String, dynamic>?> registerGoldUser(
      {required String phone,
      required String email,
      required String userId,
      required String name,
      required int pincode,
      required String city,
      required String state,
      required String dob}) async {
    Map<String, dynamic>? details;
    final authToken = await LocalDBServices.getGPAccessToken();
    safePrint(authToken);
    await HttpServices.sendPostReq('${_baseUrl}users', extraHeaders: {
      'Authorization': 'Bearer $authToken'
    }, body: {
      'mobileNumber': phone,
      'emailId': email,
      'uniqueId': userId,
      'userName': name,
      'userPincode': pincode,
      'userState': state,
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

  /// ------------------------ Buy Gold ------------------------------
  static Future<BuyInfo?> buyGold(
      {required User user,
      required Transaction transaction,
      required ExchangeRates rates}) async {
    BuyInfo? info;
    final authToken = await LocalDBServices.getGPAccessToken();
    await HttpServices.sendPostReq('${_baseUrl}buy', body: {
      'lockPrice': double.parse(rates.gBuy!), // number
      'metalType': 'gold', // string
      'quantity': transaction.quantity, //
      'merchantTransactionId': transaction.txId,
      'userName': "${user.fname!} ${user.lname!}",
      'uniqueId': user.id,
      'blockId': rates.blockId,
      'mobileNumber': user.phone!.substring(3),
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

  /// ---------------------------------------- sell gold------------------------------------------------->
  static Future<SellInfo?> sellGold({
      required User user,
      required String bankId,
      required Transaction transaction,
      required ExchangeRates rate}) async {
    SellInfo? info;
    final authToken = await LocalDBServices.getGPAccessToken();
    await HttpServices.sendPostReq('${_baseUrl}sell', body: {
      'uniqueId': user.id,
      'mobileNumber': user.phone!.substring(3),
      'lockPrice': double.parse(rate.gSell!),
      'blockId': rate.blockId,
      'metalType': 'gold',
      'userName': "${user.fname!} ${user.lname!}",
      'emailId': user.email,
      'quantity': transaction.quantity,
      'merchantTransactionId': transaction.id,
      'userBank[userBankId]': bankId
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

  /// <----------------------------- Redeem ---------------------------------->
  static Future<List<Map<String, dynamic>>> getUserRedeemList() async {
    List<Map<String, dynamic>> redeemList = [];

    // try {
    //   String? userId = await LocalDBServices.getGPMerchantId();
    //   if(userId != null){
    //     eq('${_baseUrl}$userId/buy').then((value) {});
    //
    //   }
    //   await HttpServices.sendGetR    } catch (e) {}

    Map<String, dynamic> redeemRList = {
      "statusCode": 200,
      "message": "Order List retrieved successfully.",
      "result": {
        "data": [
          {
            "transactionId": "OD226116025618536050068217",
            "uniqueId": "GE7794778787",
            "merchantOrderId": "bf56a3b7-1b97-4e88-b749-db52bd1e64a5",
            "invoiceNo": null,
            "shippingCharges": "1250.00",
            "modeOfPayment": "Mehul",
            "shippingAddress": {
              "name": "Ravi",
              "mobile": null,
              "address":
                  "B 110, 1st Floor, Laxmi Bhavan, Sai Baba nagar, Navghar Road, Bhayandar East",
              "state": "Andaman and Nicobar",
              "city": "North and Middle Andaman",
              "pincode": "401105"
            },
            "awbNo": null,
            "logisticName": null,
            "product": [
              {
                "sku": "AU999GC01R",
                "productName": "Augmont 1Gm Gold Coin (999 Purity)",
                "metalType": "gold",
                "quantity": "3.0000",
                "price": "350.00",
                "amount": "1050.00",
                "productImages": []
              },
              {
                "sku": "BR999S001R",
                "productName": "1 Gm Silver Bar",
                "metalType": "silver",
                "quantity": "2.0000",
                "price": "100.00",
                "amount": "200.00",
                "productImages": []
              }
            ],
            "status": "pending",
            "createdAt": "2020-10-13T04:04:13.000000Z",
            "updatedAt": "2020-10-13T04:04:13.000000Z"
          },
          {
            "transactionId": "OD262116025618626650068217",
            "uniqueId": "GE7794778787",
            "merchantOrderId": "b1267c55-150c-47ad-89a8-df912a0e0ea6",
            "invoiceNo": null,
            "shippingCharges": "550.00",
            "modeOfPayment": "Mehul",
            "shippingAddress": {
              "name": "Ravi",
              "mobile": null,
              "address":
                  "B 110, 1st Floor, Laxmi Bhavan, Sai Baba nagar, Navghar Road, Bhayandar East",
              "state": "Andaman and Nicobar",
              "city": "North and Middle Andaman",
              "pincode": "401105"
            },
            "awbNo": null,
            "logisticName": null,
            "product": [
              {
                "sku": "AU999GC01R",
                "productName": "Augmont 1Gm Gold Coin (999 Purity)",
                "metalType": "gold",
                "quantity": "1.0000",
                "price": "350.00",
                "amount": "350.00",
                "productImages": []
              },
              {
                "sku": "BR999S001R",
                "productName": "1 Gm Silver Bar",
                "metalType": "silver",
                "quantity": "2.0000",
                "price": "100.00",
                "amount": "200.00",
                "productImages": []
              }
            ],
            "status": "pending",
            "createdAt": "2020-10-13T04:04:22.000000Z",
            "updatedAt": "2020-10-13T04:04:22.000000Z"
          },
          {
            "transactionId": "OD675516025618682650068217",
            "uniqueId": "GE7794778787",
            "merchantOrderId": "4a3fba2f-518d-4bc1-ab49-1a952eb413b4",
            "invoiceNo": null,
            "shippingCharges": "900.00",
            "modeOfPayment": "Mehul",
            "shippingAddress": {
              "name": "Ravi",
              "mobile": null,
              "address":
                  "B 110, 1st Floor, Laxmi Bhavan, Sai Baba nagar, Navghar Road, Bhayandar East",
              "state": "Andaman and Nicobar",
              "city": "North and Middle Andaman",
              "pincode": "401105"
            },
            "awbNo": null,
            "logisticName": null,
            "product": [
              {
                "sku": "AU999GC01R",
                "productName": "Augmont 1Gm Gold Coin (999 Purity)",
                "metalType": "gold",
                "quantity": "2.0000",
                "price": "350.00",
                "amount": "700.00",
                "productImages": []
              },
              {
                "sku": "BR999S001R",
                "productName": "1 Gm Silver Bar",
                "metalType": "silver",
                "quantity": "2.0000",
                "price": "100.00",
                "amount": "200.00",
                "productImages": []
              }
            ],
            "status": "pending",
            "createdAt": "2020-10-13T04:04:28.000000Z",
            "updatedAt": "2020-10-13T04:04:28.000000Z"
          },
          {
            "transactionId": "OD424616025618737450068217",
            "uniqueId": "GE7794778787",
            "merchantOrderId": "49fcbf66-006f-4ee6-917c-cffaad40bfb3",
            "invoiceNo": null,
            "shippingCharges": "450.00",
            "modeOfPayment": "Mehul",
            "shippingAddress": {
              "name": "Ravi",
              "mobile": null,
              "address":
                  "B 110, 1st Floor, Laxmi Bhavan, Sai Baba nagar, Navghar Road, Bhayandar East",
              "state": "Andaman and Nicobar",
              "city": "North and Middle Andaman",
              "pincode": "401105"
            },
            "awbNo": null,
            "logisticName": null,
            "product": [
              {
                "sku": "AU999GC01R",
                "productName": "Augmont 1Gm Gold Coin (999 Purity)",
                "metalType": "gold",
                "quantity": "1.0000",
                "price": "350.00",
                "amount": "350.00",
                "productImages": []
              },
              {
                "sku": "BR999S001R",
                "productName": "1 Gm Silver Bar",
                "metalType": "silver",
                "quantity": "1.0000",
                "price": "100.00",
                "amount": "100.00",
                "productImages": []
              }
            ],
            "status": "pending",
            "createdAt": "2020-10-13T04:04:33.000000Z",
            "updatedAt": "2020-10-13T04:04:33.000000Z"
          },
          {
            "transactionId": "OD100816025620760150068217",
            "uniqueId": "GE7794778787",
            "merchantOrderId": "9f5c3dd5-17b1-4024-bc56-94af08a39ebd",
            "invoiceNo": null,
            "shippingCharges": "650.00",
            "modeOfPayment": "Mehul",
            "shippingAddress": {
              "name": "Ravi",
              "mobile": null,
              "address":
                  "B 110, 1st Floor, Laxmi Bhavan, Sai Baba nagar, Navghar Road, Bhayandar East",
              "state": "Andaman and Nicobar",
              "city": "North and Middle Andaman",
              "pincode": "401105"
            },
            "awbNo": null,
            "logisticName": null,
            "product": [
              {
                "sku": "AU999GC01R",
                "productName": "Augmont 1Gm Gold Coin (999 Purity)",
                "metalType": "gold",
                "quantity": "1.0000",
                "price": "350.00",
                "amount": "350.00",
                "productImages": []
              },
              {
                "sku": "AU999GC005R",
                "productName": "Augmont 0.5Gm Gold Coin (999 Purity)",
                "metalType": "gold",
                "quantity": "1.0000",
                "price": "300.00",
                "amount": "300.00",
                "productImages": [
                  {
                    "url":
                        "https://uat-augmontgold.s3.ap-south-1.amazonaws.com/products/7/gallery/b5d5c3ddb9bf39fcabaa8cb3213f75b6.png",
                    "displayOrder": 3,
                    "defaultImage": true
                  }
                ]
              }
            ],
            "status": "pending",
            "createdAt": "2020-10-13T04:07:56.000000Z",
            "updatedAt": "2020-10-13T04:07:56.000000Z"
          }
        ],
        "pagination": {
          "hasMore": false,
          "count": 5,
          "per_page": 10,
          "current_page": 1
        }
      }
    };
    if (redeemRList['statusCode'] == 200) {
      return redeemRList['result']['data'];
    } else {
      return redeemList;
    }
  }

  static Future<Map<String, dynamic>> getRedeemInfo(
      {required String sellTxnId}) async {
    Map<String, dynamic> withdrawInfo = {
      "statusCode": 200,
      "message": "Redeem Record Exists with this Order Id",
      "result": {
        "data": {
          "transactionId": "OD100816025620760150068217",
          "uniqueId": "GE7794778787",
          "merchantOrderId": "9f5c3dd5-17b1-4024-bc56-94af08a39ebd",
          "invoiceNo": null,
          "shippingCharges": "650.00",
          "modeOfPayment": "Mehul",
          "shippingAddress": {
            "name": "Ravi",
            "mobile": null,
            "address":
                "B 110, 1st Floor, Laxmi Bhavan, Sai Baba nagar, Navghar Road, Bhayandar East",
            "state": "Andaman and Nicobar",
            "city": "North and Middle Andaman",
            "pincode": "401105"
          },
          "awbNo": null,
          "logisticName": null,
          "productDetails": [
            {
              "sku": "AU999GC01R",
              "productName": "Augmont 1Gm Gold Coin (999 Purity)",
              "metalType": "gold",
              "quantity": "1.0000",
              "price": "350.00",
              "amount": "350.00",
              "productImages": []
            },
            {
              "sku": "AU999GC005R",
              "productName": "Augmont 0.5Gm Gold Coin (999 Purity)",
              "metalType": "gold",
              "quantity": "1.0000",
              "price": "300.00",
              "amount": "300.00",
              "productImages": [
                {
                  "url":
                      "https://uat-augmontgold.s3.ap-south-1.amazonaws.com/products/7/gallery/b5d5c3ddb9bf39fcabaa8cb3213f75b6.png",
                  "displayOrder": 3,
                  "defaultImage": true
                }
              ]
            }
          ],
          "status": "Pending",
          "createdAt": "2020-10-13T04:07:56.000000Z",
          "updatedAt": "2020-10-13T04:07:56.000000Z"
        }
      }
    };

    return withdrawInfo['result']['data'];
  }

  /// <----------------------------- Bank ------------------------------------>
// create bank account
  static Future<UserBank?> createBankAccount(
      {required String accNo,
      required String accName,
      required String ifsc,
      required String userId}) async {
    UserBank? bank;
    final authToken = await LocalDBServices.getGPAccessToken();
    await HttpServices.sendPostReq('${_baseUrl}users/$userId/banks',
        extraHeaders: {
          'Authorization': 'Bearer $authToken'
        },
        body: {
          'accountNumber': int.parse(accNo),
          'accountName': accName,
          'ifscCode': ifsc,
          'status': 'active'
        }).then((value) {
      logWithColor(message: value.toString());
      if (value == null) {
        return;
      }
      if (!value.containsKey('statusCode') || value['statusCode'] != 200) {
        return;
      }
      bank = UserBank.fromJson(value['result']['data']);
      safePrint(bank);
    });
    return bank;
  }

  // delete user bank
  static Future<bool?> deleteUserBank(
      {required BankAccount bankAccount, required String userId}) async {
    await HttpServices.sendDeleteRequest(
            '$_baseUrl/users/$userId/banks/${bankAccount.bankId}')
        .then((value) {
      return value;
    });
    return false;
  }

  // Update bank account
  static Future<UserBank?> updateBankAccount(
      {required BankAccount bankAccount, required String userId}) async {
    UserBank? bank;
    final authToken = await LocalDBServices.getGPAccessToken();
    await HttpServices.sendPostReq(
        '${_baseUrl}users/$userId/banks/${bankAccount.bankId}',
        extraHeaders: {
          'Authorization': 'Bearer $authToken'
        },
        body: {
          'accountNumber': int.parse(bankAccount.accNo!),
          'accountName': bankAccount.accName,
          'ifscCode': bankAccount.ifsc,
          'status': bankAccount.status == true ? 'active' : 'deactive',
          '_method': 'PUT',
        }).then((value) {
      if (value == null) {
        return;
      }
      debugPrint('status of bank update-----------> ${value['statusCode']}');
      if (!value.containsKey('statusCode') || value['statusCode'] != 200) {
        return;
      }
      bank = UserBank.fromJson(value['result']['data']);
      safePrint(bank?.toJson().toString());
    });
    return bank;
  }

  // get user bank
  static Future<UserBank?> getUserBank(
      {required String userId, required}) async {
    UserBank? userBankAcc;
    final authToken = await LocalDBServices.getGPAccessToken();
    await HttpServices.sendGetReq(
      'users/$userId/banks',
      extraHeaders: {'Authorization': 'Bearer $authToken'},
    ).then((value) {
      if (value == null) {
        return;
      }
      if (!value.containsKey('statusCode') || value['statusCode'] == 200) {
        return;
      }
      userBankAcc = UserBank.fromJson(value['result']['data']);
    });
    return userBankAcc;
  }

  // get gold rate
  static Future<ExchangeRates?> getMetalsRate() async {
    ExchangeRates? rates;
    // await GoldServices.sessionLogIn();
    final authToken = await LocalDBServices.getGPAccessToken();
    await HttpServices.sendGetReq('${_baseUrl}rates',
        extraHeaders: {'Authorization': 'Bearer $authToken'}).then((result) {
      safePrint('result  000000-> $result');

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

  /// <-------------------------------- User Address ------------------------------------->
  // Add user address
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
    final authToken = await LocalDBServices.getGPAccessToken();
    await HttpServices.sendPostReq('${_baseUrl}users/${user.id}/address',
        body: {
          'name': name,
          'mobileNumber': phone ?? user.phone!.substring(3),
          'address': address,
          'pincode': pincode,
          'email': email ?? user.email,
          'state': state,
          'city': city
        },
        extraHeaders: {
          'Authorization': 'Bearer $authToken'
        }).then((addr) async {
      if (addr == null) {
        return;
      }
      if (!addr.containsKey('statusCode') || addr['statusCode'] != 200) {
        return;
      }
      rsp = UserAddressResponse.fromJson(addr['result']['data']);
      safePrint(rsp!.toJson());
    });
    return rsp;
  }

  // add kyc details
  static Future<Map<String, dynamic>?> addKycDetails(
      {
      // required String path,
      required File file,
      required String panNo,
      required String dob,
      required String name}) async {
    Map<String, dynamic>? result;
    final authToken = await LocalDBServices.getGPAccessToken();
    await HttpServices.sendMultipartRequest('${_baseUrl}users/test2/kyc',
        files: [
          {'name': 'panAttachment', 'file': file}
        ],
        body: {
          'panNumber': panNo,
          'dateOfBirth': dob,
          'nameAsPerPan': name,
          'status': 'pending'
        },
        extraheaders: {
          'Authorization': 'Bearer $authToken'
        }).then((value) {
      safePrint(value);
      if (value == null) {
        return;
      }
      result = value['result']['data'];
    });
    return result;
  }

  /// --------------------------
}
