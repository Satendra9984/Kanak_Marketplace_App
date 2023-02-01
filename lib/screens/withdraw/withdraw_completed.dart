import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasvat/models/transaction_model.dart';
import 'package:tasvat/screens/buy/buy_completed.dart';
import 'package:tasvat/screens/sell/sell_completed_screen.dart';

import '../../utils/app_constants.dart';
import '../../widgets/row_details_widget.dart';
import 'book_completed.dart';

class WithdrawCompletedScreen extends StatelessWidget {
  final Transaction buyOrderDetails;
  final String id;
  const WithdrawCompletedScreen({
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
        child: SingleChildScrollView(
          child: Column(
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
                    'Withdraw Completed',
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
                        'ID: $id',
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

                  /// Order Tracking
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(10),
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
                          'Order Tracking',
                          style: TextStyle(
                            color: text300,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Other Details',
                      style: TextStyle(
                        fontSize: body1,
                        color: text500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // const SizedBox(height: 5),

                  /// Identification
                  Container(
                    margin: const EdgeInsets.all(10),
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
                          'Identification',
                          style: TextStyle(
                            color: text300,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 25),
                        RowDetailWidget(
                            title: 'Tx Type',
                            value: buyOrderDetails.activityName),
                        const SizedBox(height: 25),
                        RowDetailWidget(
                            title: 'Withdraw Amount',
                            value: '${buyOrderDetails.quantity} mace'),
                      ],
                    ),
                  ),

                  /// vendor details
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: text100,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Time',
                          style: TextStyle(
                            color: text300,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Wednesday, Sep 10th 2021',
                          style: TextStyle(
                            color: text400,
                            fontSize: body1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          'Vendor',
                          style: TextStyle(
                              color: text300,
                              fontSize: body2,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Goldia Hanoi',
                          style: TextStyle(
                            color: text400,
                            fontSize: heading2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '96 Kim Ma St., Ba Dinh, Hanoi',
                          style: TextStyle(
                            color: text300,
                            fontSize: body1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
