import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/screens/withdraw/view_details.dart';

import '../../app_constants.dart';
import '../../models/transaction_model.dart';

class BookCompletedScreen extends StatelessWidget {
  final Transaction buyOrderDetails;
  final String id;
  const BookCompletedScreen({
    Key? key,
    required this.buyOrderDetails,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: back to home
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Icon(
                  Icons.calendar_month,
                  size: 100,
                  color: accent1,
                ),
                const SizedBox(height: 40),
                Text(
                  'Buy Completed',
                  style: TextStyle(
                    fontSize: title,
                    color: text500,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Go to vendor address to complete your order',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: text300,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                /// confirm button
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => ViewBookingDetailsScreen(
                              buyOrderDetails: buyOrderDetails, id: id),
                        ),
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
                      'View Details',
                      style: TextStyle(
                        color: text100,
                        fontSize: heading2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      /// back to home screen
                      Navigator.popUntil(
                        context,
                        (route) => route.isFirst,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      minimumSize: const Size(double.infinity, 50.0),
                      maximumSize: const Size(double.infinity, 60.0),
                      backgroundColor: text100,
                    ),
                    child: Text(
                      'Back to Home',
                      style: TextStyle(
                        color: text400,
                        fontSize: 16.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
