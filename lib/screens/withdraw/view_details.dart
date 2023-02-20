import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/Transaction.dart';
import '../../utils/app_constants.dart';
import '../../widgets/row_details_widget.dart';

class ViewBookingDetailsScreen extends StatelessWidget {
  final Transaction buyOrderDetails;

  const ViewBookingDetailsScreen({
    Key? key,
    required this.buyOrderDetails,
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
                    backgroundColor: warning.withOpacity(0.15),
                    child: Icon(
                      FontAwesomeIcons.rotate,
                      size: 32,
                      color: warning,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Expire On ${buyOrderDetails.datetime.toString().substring(0, 10)}',
                      style: TextStyle(
                        fontSize: heading2,
                        color: text500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

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
                            title: 'Transaction Type',
                            value: buyOrderDetails.type!),
                        const SizedBox(height: 25),
                        RowDetailWidget(
                            title: 'Amount',
                            value: '${buyOrderDetails.amount} gm'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),

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
