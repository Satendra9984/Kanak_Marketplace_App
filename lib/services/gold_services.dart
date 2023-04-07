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

class GoldServices {
  static const String _baseUrl =
      'https://uat-api.augmontgold.com/api/merchant/v1/';

  static Future<Map<dynamic, dynamic>> getUserDetails() async {
    Map<dynamic, dynamic> detailsMap = {};

    detailsMap = {
      "statusCode": 200,
      "message": "User details retrieved successfully.",
      "result": {
        "data": {
          "userName": "Vikrant Lad",
          "dateOfBirth": "1994-01-24",
          "gender": null,
          "userEmail": "vikrant@gmail.com",
          "userAddress": "Sej Plaze, Malad West",
          "userStateId": "qYMjvMvX",
          "userCityId": "z6KkbrMb",
          "userPincode": "401105",
          "nomineeName": "Vishal",
          "nomineeRelation": "Brother",
          "nomineeDateOfBirth": "2001-02-11",
          "kycStatus": "Pending",
          "userState": "Maharashtra",
          "userCity": "Mumbai City"
        }
      }
    };
    return detailsMap['result']['data'];
  }

  static Future<List<dynamic>> getAddressList() async {
    List<dynamic> addressList = [];

    try {
      // String? uid = await LocalDBServices.getGPMerchantId();
      // if (uid == null) {
      //   return addressList;
      // }
      // await HttpServices.sendGetReq('${_baseUrl}users/$uid/banks')
      //     .then((listMap) {
      //   if (listMap != null && listMap['statusCode'] == 200) {
      //     addressList = listMap['result'];
      //     return addressList;
      //   }
      // });

      Map<dynamic, dynamic> listMap = {
        "statusCode": 200,
        "message": "User Address List retrieved successfully.",
        "result": [
          {
            "userAddressId": "vLB5pWGY",
            "userAccountId": "g5K3yBeO",
            "name": "Sunil Shukla",
            "email": "sunil.shukla@gmail.com",
            "address": "Zaveri Bazaar, Kalbadevi, Mumbai",
            "stateId": "qYMjvMvX",
            "cityId": "z6KkbrMb",
            "pincode": 400002,
            "status": "active"
          },
          {
            "userAddressId": "XVBL0BRl",
            "userAccountId": "g5K3yBeO",
            "name": "Kaustubh Parab",
            "email": "kaustubh.parab@ambab.com",
            "address": "Zaveri Bazaar, Kalbadevi, Mumbai",
            "stateId": "qYMjvMvX",
            "cityId": "z6KkbrMb",
            "pincode": 400002,
            "status": "active"
          },
          {
            "userAddressId": "OjM4nWNz",
            "userAccountId": "g5K3yBeO",
            "name": "Pratik Padwal",
            "email": "pratikpadwal@gmail.com",
            "address": "Zaveri Bazaar, Kalbadevi, Mumbai",
            "stateId": "qYMjvMvX",
            "cityId": "z6KkbrMb",
            "pincode": 400002,
            "status": "active"
          }
        ]
      };
      if (listMap['statusCode'] == 200) {
        addressList = listMap['result'];
        return addressList;
      }
    } catch (e) {
      debugPrint(e.toString());
      return addressList;
    }

    return addressList;
  }

  static Future<List<dynamic>> getUserBanksList() async {
    List<dynamic> addressList = [];

    try {
      // String? uid = await LocalDBServices.getGPMerchantId();
      // if (uid == null) {
      //   return addressList;
      // }
      // await HttpServices.sendGetReq('${_baseUrl}users/$uid/banks')
      //     .then((listMap) {
      //   if (listMap != null && listMap['statusCode'] == 200) {
      //     addressList = listMap['result'];
      //     return addressList;
      //   }
      // });

      Map<dynamic, dynamic> listMap = {
        "statusCode": 200,
        "message": "User Bank Detail List retrieved successfully.",
        "result": [
          {
            "userBankId": "nXMbVMGA",
            "uniqueId": "UNIQUEID0002",
            "bankId": "XgWeevW1",
            "bankName": "FIRSTRAND BANK LIMITED",
            "accountNumber": "112847788538",
            "accountName": "Ravi",
            "ifscCode": "FIRA0A0A585",
            "status": "active"
          },
          {
            "userBankId": "4oBpvKQO",
            "uniqueId": "UNIQUEID0002",
            "bankId": null,
            "bankName": null,
            "accountNumber": "992597788538",
            "accountName": "Ravi",
            "ifscCode": "HDFC043640A",
            "status": "active"
          },
          {
            "userBankId": "O5WZvW9z",
            "uniqueId": "UNIQUEID0002",
            "bankId": "maMyDBbD",
            "bankName": "DICGC",
            "accountNumber": "992597788538",
            "accountName": "Ravi",
            "ifscCode": "HSBC043640A",
            "status": "active"
          },
          {
            "userBankId": "qzW9mW89",
            "uniqueId": "UNIQUEID0002",
            "bankId": "34BXoDW5",
            "bankName": "NKGSB CO-OP BANK LTD",
            "accountNumber": "9000100001247",
            "accountName": "Mahesh",
            "ifscCode": "NKGS0794478",
            "status": "active"
          },
          {
            "userBankId": "g5K3yBeO",
            "uniqueId": "UNIQUEID0002",
            "bankId": null,
            "bankName": null,
            "accountNumber": "002801255144",
            "accountName": "Sunil Shukla",
            "ifscCode": "ICIC0BHAESA",
            "status": "active"
          }
        ]
      };

      if (listMap['statusCode'] == 200) {
        addressList = listMap['result'];
        return addressList;
      }
    } catch (e) {
      debugPrint(e.toString());
      return addressList;
    }

    return addressList;
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
          'accountNumber': accNo,
          'accountName': accName,
          'ifscCode': ifsc,
          'status': 'active'
        }).then((value) {
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

  static Future<List<Map<String, dynamic>>> getUserBuyList() async {
    List<Map<String, dynamic>> buylist = [];

    // try {
    //   String? userId = await LocalDBServices.getGPMerchantId();
    //   if(userId != null){
    //     eq('${_baseUrl}$userId/buy').then((value) {});
    //
    //   }
    //   await HttpServices.sendGetR    } catch (e) {}

    Map<String, dynamic> buyList = {
      "statusCode": 200,
      "message": "Buy List retrieved successfully.",
      "result": {
        "data": [
          {
            "transactionId": "BI518616009535390143",
            "merchantTransactionId": "c763ea10-7366-43bf-8060-62768faba501",
            "uniqueId": "UNIQUEID00061",
            "type": "silver",
            "qty": "10.0000",
            "exclTaxRate": 60.63,
            "inclTaxRate": 62.45,
            "exclTaxAmt": 606.3,
            "inclTaxAmt": 624.49,
            "taxRate": 3,
            "taxAmt": "18.19",
            "discountAmt": null,
            "cancelId": "CXL929616012709117943",
            "createdAt": "2020-09-24T13:18:59.000000Z"
          },
          {
            "transactionId": "BI485916009257976843",
            "merchantTransactionId": "231d0c3c-4bbc-4cae-b01a-e5096eeda8a1",
            "uniqueId": "UNIQUEID00061",
            "type": "silver",
            "qty": "10.0000",
            "exclTaxRate": 60.24,
            "inclTaxRate": 62.05,
            "exclTaxAmt": 602.4,
            "inclTaxAmt": 620.47,
            "taxRate": 3,
            "taxAmt": "18.07",
            "discountAmt": null,
            "cancelId": null,
            "createdAt": "2020-09-24T05:36:37.000000Z"
          },
          // {
          //   "transactionId": "AB27361598445100031",
          //   "merchantTransactionId": "05376c01-8cdd-405d-b2a4-109c91f22b15",
          //   "type": "silver",
          //   "qty": "0.1000",
          //   "rate": "64.43",
          //   "amount": "6.44",
          //   "createdAt": "2020-08-26T12:31:40.000000Z"
          // },
          {
            "transactionId": "BI115116009257904443",
            "merchantTransactionId": "a641ea01-f0ba-4a3d-8e1f-082757c07979",
            "uniqueId": "UNIQUEID00061",
            "type": "gold",
            "qty": "10.0000",
            "exclTaxRate": 5160.3,
            "inclTaxRate": 5315.11,
            "exclTaxAmt": 51603,
            "inclTaxAmt": 53151.09,
            "taxRate": 3,
            "taxAmt": "1548.09",
            "discountAmt": null,
            "cancelId": null,
            "createdAt": "2020-09-24T05:36:30.000000Z"
          }
        ],
        "pagination": {
          "hasMore": false,
          "count": 3,
          "per_page": 10,
          "current_page": 1
        }
      }
    };
    if (buyList['statusCode'] == 200) {
      return buyList['result']['data'];
    } else {
      return buylist;
    }
  }

  static Future<Map<String, dynamic>> getBuyInfo(
      {required String buyTxnId}) async {
    Map<String, dynamic> buyInfo = {
      "statusCode": 200,
      "message": "Buy Transaction Record Exists with this Buy.",
      "result": {
        "data": {
          "quantity": "20.0000",
          "totalAmount": "107573.20",
          "preTaxAmount": "104440.00",
          "rate": "5222.00",
          "uniqueId": "GE7794778787",
          "transactionId": "MD755616025611553150068217",
          "userName": "Ravi Ramswaroop",
          "mobileNumber": "7794778787",
          "goldBalanceInGM": "20.0000",
          "silverBalanceInGM": "20.2000",
          "IsCancelled": "No",
          "taxes": {
            "totalTaxAmount": "3133.20",
            "taxSplit": [
              {"type": "CGST", "taxPerc": "1.50", "taxAmount": "1566.60"},
              {"type": "SGST", "taxPerc": "1.50", "taxAmount": "1566.60"},
              {"type": "IGST", "taxPerc": "0.00", "taxAmount": "0.00"}
            ]
          },
          "invoiceNumber": "GMD102112",
          "updatedAt": "2020-10-13 09:22:35"
        },
        "transactionId": "MD755616025611553150068217"
      }
    };

    return buyInfo['result']['data'];
  }

  /// ---------------------------------------- sell gold------------------------------------------------->
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

  static Future<List<Map<String, dynamic>>> getUserSellList() async {
    List<Map<String, dynamic>> sellList = [];

    // try {
    //   String? userId = await LocalDBServices.getGPMerchantId();
    //   if(userId != null){
    //     eq('${_baseUrl}$userId/buy').then((value) {});
    //
    //   }
    //   await HttpServices.sendGetR    } catch (e) {}

    Map<String, dynamic> sellSList = {
      "statusCode": 200,
      "message": "Sell List retrieved successfully.",
      "result": {
        "data": [
          {
            "transactionId": "AB27361598445100031",
            "merchantTransactionId": "05376c01-8cdd-405d-b2a4-109c91f22b15",
            "type": "silver",
            "qty": "0.1000",
            "rate": "64.43",
            "amount": "6.44",
            "createdAt": "2020-08-26T12:31:40.000000Z"
          },
          {
            "transactionId": "AB27931598185367861",
            "merchantTransactionId": "b00121be-00fa-4a40-ac10-25ca76323ca2",
            "type": "gold",
            "qty": "1.0000",
            "rate": "0.00",
            "amount": "0.00",
            "createdAt": "2020-08-23T12:22:47.000000Z"
          },
          {
            "transactionId": "AB74081598185365811",
            "merchantTransactionId": "d7f8b8a1-215e-4eeb-bcaa-e116a21f85ea",
            "type": "gold",
            "qty": "1.0000",
            "rate": "0.00",
            "amount": "0.00",
            "createdAt": "2020-08-23T12:22:45.000000Z"
          },
          {
            "transactionId": "AB95431598185364231",
            "merchantTransactionId": "b63fd2d8-1257-4671-8dce-e43ffc2a6a5a",
            "type": "gold",
            "qty": "1.0000",
            "rate": "0.00",
            "amount": "0.00",
            "createdAt": "2020-08-23T12:22:44.000000Z"
          },
          {
            "transactionId": "AB86611598185361241",
            "merchantTransactionId": "d031841c-f4c9-4cbc-81ea-c4d8a8e96ab7",
            "type": "gold",
            "qty": "2.0000",
            "rate": "0.00",
            "amount": "0.00",
            "createdAt": "2020-08-23T12:22:41.000000Z"
          },
          {
            "transactionId": "AB51751598185356291",
            "merchantTransactionId": "08b7207e-e145-41aa-85c8-d38ad50e5805",
            "type": "gold",
            "qty": "1.0000",
            "rate": "0.00",
            "amount": "0.00",
            "createdAt": "2020-08-23T12:22:36.000000Z"
          },
          {
            "transactionId": "AB81291598185346591",
            "merchantTransactionId": "3f4cca5e-780e-41e1-86e8-1bc9ef77997a",
            "type": "silver",
            "qty": "10.0000",
            "rate": "0.00",
            "amount": "0.00",
            "createdAt": "2020-08-23T12:22:26.000000Z"
          },
          {
            "transactionId": "AB18261598185346561",
            "merchantTransactionId": "3f4cca5e-780e-41e1-86e8-1bc9ef77997a",
            "type": "gold",
            "qty": "1.0000",
            "rate": "0.00",
            "amount": "0.00",
            "createdAt": "2020-08-23T12:22:26.000000Z"
          },
          {
            "transactionId": "AB43041598185115541",
            "merchantTransactionId": "200e33a3-fe4a-42cd-93af-3a605757b6d1",
            "type": "silver",
            "qty": "0.2000",
            "rate": "68.13",
            "amount": "13.63",
            "createdAt": "2020-08-23T12:18:35.000000Z"
          },
          {
            "transactionId": "AB68091598185110831",
            "merchantTransactionId": "9c56d4ad-c20b-4fdf-b6e9-52a80a437faa",
            "type": "silver",
            "qty": "0.1500",
            "rate": "68.13",
            "amount": "10.22",
            "createdAt": "2020-08-23T12:18:30.000000Z"
          }
        ],
        "pagination": {
          "hasMore": true,
          "count": 10,
          "per_page": 10,
          "current_page": 1
        }
      }
    };
    if (sellSList['statusCode'] == 200) {
      return sellSList['result']['data'];
    } else {
      return sellList;
    }
  }

  static Future<Map<String, dynamic>> getSellInfo(
      {required String sellTxnId}) async {
    Map<String, dynamic> sellInfo = {
      "statusCode": 200,
      "message": "Sell Transaction Record Exists with this Sell.",
      "result": {
        "data": {
          "quantity": "0.1000",
          "totalAmount": "6.82",
          "preTaxAmount": "6.82",
          "metalType": "silver",
          "rate": "0.00",
          "uniqueId": "UNIQUEID006543",
          "transactionId": "MB11501598872681361",
          "userName": "D'souza",
          "merchantTransactionId": "6df4b1bc-b8c7-4fa9-8efa-686b7ffb4ef3",
          "mobileNumber": "9321157769",
          "goldBalance": "28.0000",
          "silverBalance": "46.4000",
          "IsCancelled": "No"
        }
      }
    };

    return sellInfo['result']['data'];
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

  // get user bank
  static Future<UserBank?> getUserBank({required String userId}) async {
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
