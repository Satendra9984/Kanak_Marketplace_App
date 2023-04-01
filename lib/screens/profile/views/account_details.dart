import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/services/gold_services.dart';
import 'package:tasvat/utils/app_constants.dart';

class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({Key? key}) : super(key: key);

  Future<Map<dynamic, dynamic>> getProfileDetails() async {
    return await GoldServices.getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0.0,
        title: const Text('Account details'),
      ),
      body: FutureBuilder(
        future: getProfileDetails(),
        builder: (context, listSnap) {
          if (listSnap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (listSnap.hasError == false) {
            Map<dynamic, dynamic> list = listSnap.data!;
            return Container(
              margin: const EdgeInsets.only(top: 25, left: 15),
              child: Column(
                children: [
                  ...list.keys.map((key) {
                    return rowDetailUser(key, list[key].toString());
                  }).toList(),
                ],
              ),
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

  Widget rowDetailUser(String key, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: 5,
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
                  fontSize: body1, fontWeight: FontWeight.w500, color: text500),
            ),
          ),
        ],
      ),
    );
  }
}
