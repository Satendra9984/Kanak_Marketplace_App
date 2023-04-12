import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/providers/user_provider.dart';
import 'package:tasvat/services/gold_services.dart';
import 'package:tasvat/utils/app_constants.dart';

import '../../../models/Address.dart';
import '../../../models/User.dart';

class AccountDetailsScreen extends ConsumerWidget {
  const AccountDetailsScreen({Key? key}) : super(key: key);

  Future<Map<String, dynamic>?> getProfileDetails(WidgetRef ref) async {
    try {
      String uid = ref.read(userProvider)!.id;
      Map<String, dynamic>? res =
          await GoldServices.getUserDetails(userId: uid);
      debugPrint(res.toString());
      return res;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  String _getDefaultAddress(WidgetRef ref) {
    User user = ref.read(userProvider)!;
    List<Address> addList = user.address ?? [];
    String? defaultAddress = user.defaultAddr;
    debugPrint('defaultAddress: $defaultAddress');
    Address defAdd =
        addList.firstWhere((element) => element.id == defaultAddress);
    return defAdd.address!;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0.0,
        title: const Text('Account details'),
      ),
      body: FutureBuilder(
        future: getProfileDetails(ref),
        builder: (context, AsyncSnapshot<Map<String, dynamic>?> listSnap) {
          if (listSnap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (listSnap.hasError == false && listSnap.data != null) {
            Map<String, dynamic> list = listSnap.data!;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                margin: const EdgeInsets.only(top: 25, left: 10, right: 10),
                child: Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        Positioned(
                          top: height * 0,
                          height: height * 0.4,
                          child: Container(
                            // margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            decoration: BoxDecoration(
                              color: text100,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Personal Details',
                                  style: TextStyle(
                                    fontSize: heading2,
                                    color: text500,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                rowDetailUser('Username', list['userName']),
                                rowDetailUser(
                                    'Date of Birth', list['dateOfBirth']),
                                rowDetailUser(
                                    'Gender', list['gender'].toString()),
                                rowDetailUser(
                                    'User Email', list['userEmail'].toString()),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: height * 0.3,
                          child: Container(
                            // margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            decoration: BoxDecoration(
                              color: text100,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Personal Details',
                                  style: TextStyle(
                                    fontSize: heading2,
                                    color: text500,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                rowDetailUser('Username', list['userName']),
                                rowDetailUser(
                                    'Date of Birth', list['dateOfBirth']),
                                rowDetailUser(
                                    'Gender', list['gender'].toString()),
                                rowDetailUser(
                                    'User Email', list['userEmail'].toString()),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: accentBG.withOpacity(0.75),
                      child: Icon(Icons.person,
                          size: 78, color: accent1.withOpacity(0.5)),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      // margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                        color: text100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Personal Details',
                            style: TextStyle(
                              fontSize: heading2,
                              color: text500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          rowDetailUser('Username', list['userName']),
                          rowDetailUser('Date of Birth', list['dateOfBirth']),
                          rowDetailUser('Gender', list['gender'].toString()),
                          rowDetailUser(
                              'User Email', list['userEmail'].toString()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      // margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                        color: text100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address',
                            style: TextStyle(
                              fontSize: heading2,
                              color: text500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // rowDetailUser(
                          //     'Address', list['userAddress'].toString()),
                          rowDetailUser('State', list['userState'].toString()),
                          rowDetailUser('City', list['userCity'].toString()),
                          rowDetailUser(
                              'Pincode', list['userPincode'].toString()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      // margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                        color: text100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kyc',
                            style: TextStyle(
                              fontSize: heading2,
                              color: text500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          rowDetailUser('Kyc Status', list['kycStatus']),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      // margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                        color: text100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nominee Details',
                            style: TextStyle(
                              fontSize: heading2,
                              color: text500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          rowDetailUser(
                              'Nominee Name', list['nomineeName'].toString()),
                          rowDetailUser('Nominee Relation',
                              list['nomineeRelation'].toString()),
                          rowDetailUser('Nominee D.O.B.',
                              list['nomineeDateOfBirth'].toString()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Something Went Wrong'));
          }
        },
      ),
    );
  }

  Widget rowDetailUser(String key, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              key,
              style: TextStyle(
                  fontSize: body1, fontWeight: FontWeight.w400, color: text400),
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
