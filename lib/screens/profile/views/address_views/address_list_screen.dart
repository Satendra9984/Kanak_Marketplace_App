import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/screens/profile/views/address_views/update_user_address.dart';
import 'package:tasvat/screens/registration/view/user_address.dart';
import 'package:tasvat/services/gold_services.dart';
import 'package:tasvat/services/rest_services.dart';
import 'package:tasvat/utils/app_constants.dart';

import 'add_user_address_screen.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({Key? key}) : super(key: key);

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  Future<List<Map<dynamic, dynamic>>> getAddress() async {
    List<Map<dynamic, dynamic>> addressList = [];
    try {
      await GoldServices.getAddressList().then((addList) {
        debugPrint('addressList\ntype: ${addressList.runtimeType}');
        for (var addressMap in addList) {
          Map<dynamic, dynamic> address =
              Map<dynamic, dynamic>.from(addressMap);
          addressList.add(address);
          //debugPrint(addressList.toString());
        }

        return addressList;
      });
    } catch (e) {
      return addressList;
    }
    return addressList;
  }

  Future<void> deleteUserAddress() async {
    // TODO: DELETE USER ADDRESS
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        title: Text(
          'Addresses',
          style: TextStyle(
            color: text500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => const AddUserAddressPage()),
              );
            },
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  color: accent2,
                ),
                Text(
                  'add',
                  style: TextStyle(
                    color: accent2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getAddress(),
        builder: (context, listSnap) {
          if (listSnap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (listSnap.hasError == false) {
            List<Map<dynamic, dynamic>> list = listSnap.data!;
            // debugPrint(list.toString());
            return Container(
              margin: const EdgeInsets.only(top: 25),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (ctx, index) {
                    return addressWidget(list[index]);
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

  Widget addressWidget(Map<dynamic, dynamic> address) {
    return Column(
      children: [
        // rowDetailAddress('Name', address['name'].toString()),
        // rowDetailAddress('Email', address['email'].toString()),
        // rowDetailAddress('Address', address['address'].toString()),
        // rowDetailAddress('State', address['stateId'].toString()),
        // rowDetailAddress('City', address['cityId'].toString()),
        // rowDetailAddress('Pincode', address['pincode'].toString()),
        // rowDetailAddress('Status', address['status'].toString()),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          decoration: BoxDecoration(
            // border: Border.all(
            //   color: text150,
            //   width: 0.00,
            // ),
            // color: text100,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => const UpdateUserAddressPage()),
              );
            },
            leading: Icon(
              Icons.location_city,
              color: text400,
            ),
            title: Text(
              address['address'],
              style: TextStyle(
                  fontSize: body1, fontWeight: FontWeight.w400, color: text500),
            ),
            subtitle: Text(
              address['pincode'].toString(),
              style: TextStyle(
                  fontSize: body2, fontWeight: FontWeight.w400, color: text500),
            ),
            trailing: PopupMenuButton(
              onSelected: (value) {
                if (value == 'Edit') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const UpdateUserAddressPage()),
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
                    onTap: () async {
                      await deleteUserAddress().then((value) {
                        setState(() {});
                      });
                    },
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
              icon: Icon(Icons.more_vert, color: text400),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }

  Widget rowDetailAddress(String key, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(key,
                style: TextStyle(fontWeight: FontWeight.w400, color: text400)),
          ),
          Expanded(
            flex: 7,
            child: Text(value,
                style: TextStyle(
                    fontSize: body2,
                    fontWeight: FontWeight.w500,
                    color: text500)),
          ),
        ],
      ),
    );
  }
}
