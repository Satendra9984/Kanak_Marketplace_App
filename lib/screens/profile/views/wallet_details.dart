import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/providers/user_provider.dart';

import '../../../utils/app_constants.dart';
import '../../withdraw_money/views/withdraw_money_screen.dart';

class WalletDetailsScreen extends ConsumerWidget {
  const WalletDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0.0,
        actions: [
          TextButton(
            child: Text(
              'All Transactions',
              style: TextStyle(
                fontSize: body2,
                color: accent2,
                fontWeight: FontWeight.w400,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Balance Available',
              style: TextStyle(
                fontSize: body1,
                color: text400,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              '₹${ref.watch(userProvider)!.wallet!.balance ?? '--'}',
              style: TextStyle(
                fontSize: heading1,
                color: text500,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // TODO: WITHDRAW MONEY
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) {
                        return const WithdrawMoneyScreen();
                      }),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Withdraw',
                        style: TextStyle(
                          fontSize: body2,
                          color: accent2,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12,
                        color: accent2,
                      ),
                    ],
                  ),
                ),
                Text(
                  '₹${ref.watch(userProvider)!.wallet!.balance ?? '--'}',
                  style: TextStyle(
                    fontSize: body1,
                    color: text500,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
