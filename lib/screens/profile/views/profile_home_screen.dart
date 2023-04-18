import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/providers/user_provider.dart';
import 'package:tasvat/screens/profile/views/account_details.dart';
import 'package:tasvat/screens/profile/views/bank_views/user_banks_list_screen.dart';
import 'package:tasvat/screens/profile/views/wallet_details.dart';
import 'package:tasvat/utils/app_constants.dart';

import '../../../models/User.dart';
import '../../add_money/views/add_money_screen.dart';
import 'address_views/address_list_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = ref.watch(userProvider)!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (ctx) => const AccountDetailsScreen()),
              );
            },
            leading: CircleAvatar(
              backgroundColor: accentBG,
              child: Icon(
                Icons.perm_identity,
                color: text400,
              ),
            ),
            title: Text(
              '${user.fname} ${user.lname}',
              style: TextStyle(
                fontSize: heading1,
                fontWeight: FontWeight.w500,
                color: text500,
              ),
            ),
            subtitle: Text(
              'Account Details',
              style: TextStyle(
                fontSize: caption,
                fontWeight: FontWeight.w400,
                color: text500,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => AccountDetailsScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
              ),
            ),
          ),
          Divider(color: text200),

          /// BALANCE
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return WalletDetailsScreen();
              }));
            },
            leading: CircleAvatar(
              backgroundColor: background,
              child: Icon(
                Icons.wallet,
                color: text400,
              ),
            ),
            title: Text(
              '₹ ${ref.watch(userProvider)!.wallet!.balance ?? '--'}',
              style: TextStyle(
                fontSize: heading2,
                fontWeight: FontWeight.w500,
                color: text500,
              ),
            ),
            subtitle: Text(
              'Tasvat Balance',
              style: TextStyle(
                fontSize: caption,
                fontWeight: FontWeight.w300,
                color: text500,
              ),
            ),
            trailing: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => AddMoneyScreen(),
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: accentBG.withOpacity(0.5),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => AddMoneyScreen()));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add,
                        size: 16,
                        color: accent2,
                      ),
                      Text(
                        'Add Money',
                        style: TextStyle(
                          color: accent2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// All Orders
          ListTile(
            leading: CircleAvatar(
              backgroundColor: background,
              child: Icon(
                Icons.request_page,
                color: text400,
              ),
            ),
            title: Text(
              'All orders',
              style: TextStyle(
                fontSize: heading2,
                fontWeight: FontWeight.w500,
                color: text500,
              ),
            ),
            subtitle: Text(
              'Track orders, order details',
              style: TextStyle(
                fontSize: caption,
                fontWeight: FontWeight.w300,
                color: text500,
              ),
            ),
          ),

          /// Bank details
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => const UserBanksListScreen()),
              );
            },
            leading: CircleAvatar(
              backgroundColor: background,
              child: Icon(
                Icons.account_balance,
                color: text400,
              ),
            ),
            title: Text(
              'Bank Details',
              style: TextStyle(
                fontSize: heading2,
                fontWeight: FontWeight.w500,
                color: text500,
              ),
            ),
            subtitle: Text(
              'Banks & AutoPay mandates',
              style: TextStyle(
                fontSize: caption,
                fontWeight: FontWeight.w300,
                color: text500,
              ),
            ),
          ),

          /// ALL addresses
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => const AddressListScreen()),
              );
            },
            leading: CircleAvatar(
              backgroundColor: background,
              child: Icon(
                Icons.edit_location,
                color: text400,
              ),
            ),
            title: Text(
              'Address Details',
              style: TextStyle(
                fontSize: heading2,
                fontWeight: FontWeight.w500,
                color: text500,
              ),
            ),
            subtitle: Text(
              'Banks & AutoPay mandates',
              style: TextStyle(
                fontSize: caption,
                fontWeight: FontWeight.w300,
                color: text500,
              ),
            ),
          ),

          /// reports
          ListTile(
            leading: CircleAvatar(
              backgroundColor: background,
              child: Icon(
                Icons.file_copy,
                color: text400,
              ),
            ),
            title: Text(
              'Reports',
              style: TextStyle(
                fontSize: heading2,
                fontWeight: FontWeight.w500,
                color: text500,
              ),
            ),
            subtitle: Text(
              'Gold market reports',
              style: TextStyle(
                fontSize: caption,
                fontWeight: FontWeight.w300,
                color: text500,
              ),
            ),
          ),

          /// help & support
          ListTile(
            leading: CircleAvatar(
              backgroundColor: background,
              child: Icon(
                Icons.help,
                color: text400,
              ),
            ),
            title: Text(
              'Help & Support',
              style: TextStyle(
                fontSize: heading2,
                fontWeight: FontWeight.w500,
                color: text500,
              ),
            ),
            subtitle: Text(
              'FAQ, Contact Support',
              style: TextStyle(
                fontSize: caption,
                fontWeight: FontWeight.w300,
                color: text500,
              ),
            ),
          ),

          /// LogOut
          ListTile(
            onTap: () {},
            leading: CircleAvatar(
              backgroundColor: background,
              child: Icon(
                Icons.logout,
                color: text400,
              ),
            ),
            title: Text(
              'Log Out',
              style: TextStyle(
                fontSize: heading2,
                fontWeight: FontWeight.w500,
                color: text500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
