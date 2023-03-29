import 'package:flutter/material.dart';
import 'package:tasvat/screens/profile/views/bank_views/update_user_bank.dart';
import 'package:tasvat/screens/registration/view/user_bank_details.dart';
import 'package:tasvat/services/gold_services.dart';
import '../../../../utils/app_constants.dart';

class UserBanksListScreen extends StatelessWidget {
  const UserBanksListScreen({Key? key}) : super(key: key);

  Future<List<Map<dynamic, dynamic>>> getBanks() async {
    List<Map<dynamic, dynamic>> banksList = [];
    try {
      await GoldServices.getUserBanksList().then((bankList) {
        debugPrint('addressList\ntype: ${bankList.runtimeType}');
        for (var bankMap in bankList) {
          Map<dynamic, dynamic> bank = Map<dynamic, dynamic>.from(bankMap);
          banksList.add(bank);
          //debugPrint(addressList.toString());
        }

        return banksList;
      });
      return banksList;
    } catch (e) {
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
                    builder: (ctx) => const UpdateUserBankDetailsPage()),
              );
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
            List<Map<dynamic, dynamic>> list = listSnap.data!;
            return Container(
              margin: const EdgeInsets.only(top: 25),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (ctx, index) {
                    return bankWidget(list[index], context);
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

  Widget bankWidget(Map<dynamic, dynamic> bank, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        children: [
          // rowDetailBank('User Bank Id', address['userBankId'].toString()),
          // rowDetailBank('Bank Name', address['bankName'].toString()),
          // rowDetailBank('Account Number', address['accountNumber'].toString()),
          // rowDetailBank('Account Name', address['accountName'].toString()),
          // rowDetailBank('Ifsc Code', address['ifscCode'].toString()),
          // rowDetailBank('Status', address['status'].toString()),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => const UpdateUserBankDetailsPage()),
              );
            },
            leading: Icon(
              Icons.account_balance_outlined,
              color: text400,
            ),
            title: Text(
              bank['bankName'].toString(),
              style: TextStyle(
                  fontSize: body1, fontWeight: FontWeight.w400, color: text500),
            ),
            subtitle: Text(
              getAccountNumberHidden(bank['accountNumber']),
              style: TextStyle(
                  fontSize: body2, fontWeight: FontWeight.w400, color: text500),
            ),
            trailing: PopupMenuButton(
              onSelected: (value) {
                if (value == 'Edit') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const UpdateUserBankDetailsPage()),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  // PopupMenuItem(
                  //   onTap: () {},
                  //   value: 'Edit',
                  //   child: Row(
                  //     children: const [
                  //       Icon(Icons.edit, color: Colors.green),
                  //       SizedBox(width: 10),
                  //       Text('Edit'),
                  //     ],
                  //   ),
                  // ),
                  PopupMenuItem(
                    onTap: () async {},
                    value: 'Delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: error),
                        const SizedBox(width: 10),
                        const Text('Delete'),
                      ],
                    ),
                  ),
                ];
              },
              elevation: 15,
              icon: Icon(
                Icons.more_vert,
                color: text400,
              ),
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
