import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/providers/user_provider.dart';
import 'package:tasvat/screens/profile/views/address_views/update_user_address.dart';
import 'package:tasvat/services/gold_services.dart';
import 'package:tasvat/utils/app_constants.dart';
import '../../../../models/Address.dart';
import 'add_user_address_screen.dart';

class AddressListScreen extends ConsumerStatefulWidget {
  const AddressListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends ConsumerState<AddressListScreen> {
  Future<List<Address>> getAddress() async {
    List<Address> addressList = [];
    try {
      await GoldServices.getAddressList();
      List<Address> list = ref.read(userProvider)!.address ?? [];
      return list;
    } catch (e) {
      debugPrint(e.toString());
      return addressList;
    }
    return addressList;
  }

  Future<void> deleteUserAddress() async {
    // DELETE USER ADDRESS
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
            List<Address> list = listSnap.data!;
            // debugPrint(list.toString());
            // ref.read(userProvider);
            return Container(
              margin: const EdgeInsets.only(top: 25, left: 5, right: 5),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (ctx, index) {
                    return addressWidget(list[index], index);
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

  Widget addressWidget(Address address, int index, {bool isDefault = false}) {
    debugPrint('${address.id}');
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                    Icons.location_city,
                    color: accent1.withOpacity(0.75),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Address ${index + 1}',
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
                        UpdateUserAddressPage(addressForUpdation: address)),
              );
            },
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text(
                  '${address.address}',
                  style: TextStyle(
                      fontSize: body2,
                      fontWeight: FontWeight.w400,
                      color: text500),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text(
                  '${address.pincode}',
                  style: TextStyle(
                      fontSize: body1,
                      fontWeight: FontWeight.w400,
                      color: text500),
                ),
                const SizedBox(height: 5),
                Text(
                  '${address.phone}',
                  style: TextStyle(
                      fontSize: body2,
                      fontWeight: FontWeight.w600,
                      color: text400),
                ),
              ],
            ),
            trailing: PopupMenuButton(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return [
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
        ],
      ),
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
