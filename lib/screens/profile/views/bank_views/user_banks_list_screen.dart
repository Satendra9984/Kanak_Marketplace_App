import 'package:amplify_auth_cognito/amplify_auth_error_handling.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/models/BankAccount.dart';
import 'package:tasvat/screens/profile/views/bank_views/update_user_bank.dart';
import 'package:tasvat/screens/registration/view/user_bank_details.dart';
import 'package:tasvat/services/gold_services.dart';
import '../../../../utils/app_constants.dart';
import 'add_user_bank_account.dart';

class UserBanksListScreen extends StatefulWidget {
  const UserBanksListScreen({Key? key}) : super(key: key);

  @override
  State<UserBanksListScreen> createState() => _UserBanksListScreenState();
}

class _UserBanksListScreenState extends State<UserBanksListScreen> {
  Future<List<BankAccount>> getBanks() async {
    List<BankAccount> banksList = [];
    try {
      await GoldServices.getUserBanksList().then((bankList) {
        debugPrint('addressList\ntype: ${bankList.runtimeType}');
        for (var bankMap in bankList) {
          //   {
          //     "userBankId": "nXMbVMGA",
          // "uniqueId": "UNIQUEID0002",
          // "bankId": "XgWeevW1",
          // "bankName": "FIRSTRAND BANK LIMITED",
          // "accountNumber": "112847788538",
          // "accountName": "Ravi",
          // "ifscCode": "FIRA0A0A585",
          // "status": "active"
          // },

          //   id = json['id'],
          // _bankId = json['bankId'],
          // _accNo = json['accNo'],
          // _ifsc = json['ifsc'],
          // _addressId = json['addressId'],
          // _accName = json['accName'],
          // _userID = json['userID'],
          // _status = json['status'],
          // _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
          // _updatedAt = json['updatedAt'] != null ? Tempora

          var map = {
            "id": bankMap['uniqueId'] ?? '',
            "bankId": bankMap['userBankId'] ?? '',
            "accNo": bankMap['accountNumber'] ?? '',
            "ifsc": bankMap["ifscCode"] ?? '',
            "addressId": '1234rdfd',
            "accName": bankMap['accountName'] ?? '',
            "userId": '123ddfd%ffd55',
            "status": bankMap['status'] == 'active',
            "bankName": "FIRSTRAND BANK LIMITED",
          };
          BankAccount bank = BankAccount.fromJson(map);
          banksList.add(bank);
          //debugPrint(addressList.toString());
        }

        return banksList;
      });
      return banksList;
    } catch (e) {
      debugPrint(e.toString());
      return banksList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        title: Text(
          'Banks',
          style: TextStyle(
            color: text500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => const AddUserBankDetailsPage()),
              ).then((value) {
                setState(() {});
              });
            },
            child: Row(
              children: [
                Icon(Icons.add, color: accent2),
                Text('add', style: TextStyle(color: accent2)),
              ],
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getBanks(),
        builder: (context, listSnap) {
          if (listSnap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (listSnap.hasError == false) {
            List<BankAccount> list = listSnap.data!;
            String defaultBankId = 'nXMbVMGA';
            return Container(
              margin: const EdgeInsets.only(top: 25, left: 10, right: 10),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (ctx, index) {
                    return bankWidget(list[index], index,
                        isDefault: list[index].bankId == 'nXMbVMGA');
                  }),
            );
          } else {
            return const Center(
              child: Text('Something Went Wrong'),
            );
          }
        },
      ),
    );
  }

  Widget bankWidget(BankAccount bankAccount, int index,
      {bool isDefault = false}) {
    debugPrint('${bankAccount.bankId}');
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      decoration: BoxDecoration(
        color: text100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5, left: 15),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: accentBG.withOpacity(0.55),
                  child: Icon(
                    Icons.account_balance_rounded,
                    color: accent1.withOpacity(0.75),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Bank ${index + 1}',
                  style: TextStyle(
                      fontSize: heading2,
                      fontWeight: FontWeight.w500,
                      color: text500),
                ),
                const SizedBox(width: 10),
                if (isDefault == true)
                  Text(
                    '( Default )',
                    style: TextStyle(
                        fontSize: body1,
                        fontWeight: FontWeight.w500,
                        color: CupertinoColors.activeGreen),
                  ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) =>
                        UpdateUserBankDetailsPage(bankAccount: bankAccount)),
              );
            },
            title: Text(
              '${bankAccount.accName}',
              style: TextStyle(
                  fontSize: body2, fontWeight: FontWeight.w400, color: text500),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '****** ${bankAccount.accNo!.substring(bankAccount.accNo!.length - 4, bankAccount.accNo!.length)}',
                  style: TextStyle(
                      fontSize: body2,
                      fontWeight: FontWeight.w400,
                      color: text500),
                ),
                const SizedBox(height: 2.5),
              ],
            ),
            trailing: PopupMenuButton(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    onTap: () async {
                      // await deleteUserB().then((value) {
                      //   setState(() {});
                      // });
                    },
                    value: 'Delete',
                    child: Row(
                      children: [
                        // Icon(Icons.delete, color: error),
                        // const SizedBox(width: 10),
                        Text(
                          'Delete',
                          style: TextStyle(
                              fontSize: heading2,
                              fontWeight: FontWeight.w500,
                              color: text500),
                        ),
                      ],
                    ),
                  ),
                  if (isDefault == false)
                    PopupMenuItem(
                      onTap: () async {
                        // await deleteUserAddress().then((value) {
                        //   setState(() {});
                        // });
                      },
                      value: 'Make Default',
                      child: Row(
                        children: [
                          // Icon(Icons.add_rounded, color: success, size: 32),
                          // const SizedBox(width: 10),
                          Text(
                            'Make Default',
                            style: TextStyle(
                                fontSize: heading2,
                                fontWeight: FontWeight.w500,
                                color: text500),
                          ),
                          // Icon(Icons.add_rounded, color: success, size: 32),
                        ],
                      ),
                    ),
                ];
              },
              elevation: 15,
              icon: Icon(Icons.more_vert, color: text400),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }

  Widget rowDetailBank(String key, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              key,
              style: TextStyle(fontWeight: FontWeight.w400, color: text400),
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              value,
              style: TextStyle(
                  fontSize: body2, fontWeight: FontWeight.w500, color: text500),
            ),
          ),
        ],
      ),
    );
  }

  String getAccountNumberHidden(String? number) {
    if (number == null) {
      return '';
    } else {
      return '****${number.substring(number.length - 4, number.length)}';
    }
  }
}
