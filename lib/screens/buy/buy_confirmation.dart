import 'package:flutter/material.dart';
import 'package:tasvat/models/transaction_model.dart';
import 'package:tasvat/screens/buy/buy_completed.dart';

import '../../utils/app_constants.dart';
import '../../widgets/row_details_widget.dart';

class BuyConfirmationScreen extends StatelessWidget {
  final Transaction buyOrderDetails;
  final String id;
  const BuyConfirmationScreen({
    Key? key,
    required this.buyOrderDetails,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: background,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Buy Confirmation',
                    style: TextStyle(
                      fontSize: title,
                      color: text500,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                /// Identification
                Container(
                  margin: const EdgeInsets.all(10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                    color: text100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Identification',
                        style: TextStyle(
                          color: text300,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 25),
                      RowDetailWidget(
                          title: 'Transaction Type',
                          value: buyOrderDetails.activityName),
                      const SizedBox(height: 25),
                      RowDetailWidget(
                          title: 'Price',
                          value: '${buyOrderDetails.price} INR/gm'),
                      const SizedBox(height: 25),
                      RowDetailWidget(
                          title: 'Amount',
                          value: '${buyOrderDetails.quantity} gm'),
                    ],
                  ),
                ),
                const SizedBox(height: 5),

                /// Total
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: text100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            color: text300,
                            fontSize: body2,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 25),
                      RowDetailWidget(
                          title: 'Equal',
                          value:
                              '${buyOrderDetails.quantity * buyOrderDetails.price} INR'),
                      const SizedBox(height: 25),
                      const RowDetailWidget(
                          title: 'Method', value: 'Cash Wallet'),
                    ],
                  ),
                ),

                /// confirm button
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  /// proceed to buy completed SCREEN

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => BuyCompletedScreen(
                        buyOrderDetails: buyOrderDetails,
                        id: id,
                        backToHome: true,
                      ),
                    ),
                    (route) => route.isFirst,
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: const Size(double.infinity, 50.0),
                  maximumSize: const Size(double.infinity, 60.0),
                  backgroundColor: accent1,
                ),
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    color: background,
                    fontSize: heading2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
