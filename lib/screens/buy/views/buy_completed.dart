import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../models/Transaction.dart';
import '../../../utils/app_constants.dart';
import '../../../widgets/row_details_widget.dart';

class BuyCompletedScreen extends StatelessWidget {
  final Transaction buyOrderDetails;
  final bool backToHome;
  const BuyCompletedScreen({
    Key? key,
    required this.buyOrderDetails,
    this.backToHome = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: background,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              CircleAvatar(
                radius: 32,
                backgroundColor: darkGreen,
                child: Icon(
                  FontAwesomeIcons.check,
                  size: 32,
                  color: success,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Buy Completed',
                style: TextStyle(
                  fontSize: title,
                  color: text500,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ID: ${buyOrderDetails.id}',
                    style: TextStyle(
                      color: text300,
                      fontSize: body1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      //TODO: COPY TO CLIPBOARD
                    },
                    icon: Icon(
                      Icons.copy,
                      size: 18,
                      color: accent1,
                    ),
                  ),
                ],
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
                        value: buyOrderDetails.type.toString()),
                    const SizedBox(height: 25),
                    RowDetailWidget(title: 'Price', value: '${10000} INR/gm'),
                    const SizedBox(height: 25),
                    RowDetailWidget(
                        title: 'Amount', value: '${buyOrderDetails.amount} gm'),
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
                        value: '${buyOrderDetails.amount! * 100000} INR'),
                    const SizedBox(height: 25),
                    const RowDetailWidget(
                        title: 'Method', value: 'Cash Wallet'),
                  ],
                ),
              ),
            ],
          ),
          if (backToHome)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: ElevatedButton(
                onPressed: () {
                  /// proceed to buy completed SCREEN
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: const Size(double.infinity, 50.0),
                  maximumSize: const Size(double.infinity, 60.0),
                  backgroundColor: accentBG,
                ),
                child: Text(
                  'Back to Home',
                  style: TextStyle(
                    color: accent2,
                    fontSize: heading2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
