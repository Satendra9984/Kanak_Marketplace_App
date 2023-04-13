import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/providers/user_provider.dart';
import 'package:tasvat/services/gold_services.dart';
import 'package:tasvat/utils/app_constants.dart';

import '../../../models/Address.dart';
import '../../../models/User.dart';
import 'address_views/add_user_address_screen.dart';

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

                margin: const EdgeInsets.symmetric(
                    horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: CircleAvatar(
                        backgroundColor: accentBG.withOpacity(0.65),
                        minRadius: 60,
                        maxRadius: 60,
                        child: Icon(Icons.person,
                            size: 80, color: accent1.withOpacity(0.5)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: text100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Personal Details',
                                style: TextStyle(
                                  fontSize: body2,
                                  color: text400,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                    IconButton(onPressed: (){}, icon: const Icon(Icons.edit)),
                                  IconButton(onPressed: (){}, icon: const Icon(Icons.camera_alt_outlined)),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            list['userName'],
                            style: TextStyle(
                                fontSize: heading1, fontWeight: FontWeight.w400, color: text500),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            ref.read(userProvider)?.phone ?? '----',
                            style: TextStyle(
                                fontSize: body2, fontWeight: FontWeight.w500, color: text500),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            list['userEmail'],
                            style: TextStyle(
                                fontSize: body1, fontWeight: FontWeight.w400, color: text500),
                          ),
                          const SizedBox(height: 10),

                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Address',
                                style: TextStyle(
                                  fontSize: body2,
                                  color: text400,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                                  return const AddUserAddressPage();
                                }));
                              }, child: Text('Add new', style: TextStyle(
                                fontSize:caption,
                                color: warning,
                                fontWeight: FontWeight.w600,
                              ),)),
                            ],
                          ),
                          // const SizedBox(height: 10),
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
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: TextStyle(
                fontSize: body2, fontWeight: FontWeight.w400, color: text400),
          ),
          const SizedBox(height: 2.5),
          Text(
            value,
            style: TextStyle(
                fontSize: body1, fontWeight: FontWeight.w500, color: text500),
          ),
        ],
      ),
    );
  }
}
