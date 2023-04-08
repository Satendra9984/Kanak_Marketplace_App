import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../models/Transaction.dart';
import '../../../models/TransactionStatus.dart';
import '../../../utils/app_constants.dart';
import '../../../widgets/row_details_widget.dart';
import '../bloc/buy_bloc.dart';

class BuyCompletedScreen extends StatelessWidget {
  final bool backToHome;
  final Transaction transaction;
  const BuyCompletedScreen({
    Key? key,
    required this.transaction,
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
      body: Builder(
        builder: (ctxt) {
          if (transaction.status == TransactionStatus.SUCCESSFUL) {
            return transactionSuccessWidget(transaction, ctxt);
          } else if (transaction.status == TransactionStatus.PENDING) {
            return transactionFailedWidget(transaction, ctxt);
          } else {
            return transactionPendingWidget(transaction, ctxt);
          }
        },
      ),
    );
  }

  Widget transactionSuccessWidget(
      Transaction transaction, BuildContext context) {
    return Column(
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
                  'ID: ${transaction.id}',
                  style: TextStyle(
                    color: text300,
                    fontSize: body1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: () {},
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                      value: transaction.type.toString()),
                  const SizedBox(height: 25),
                  RowDetailWidget(
                      title: 'Price',
                      value: '${transaction.lockPrice!} INR/gm'),
                  const SizedBox(height: 25),
                  RowDetailWidget(
                      title: 'Amount', value: '${transaction.amount} gm'),
                ],
              ),
            ),
            const SizedBox(height: 5),

            /// Total
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                      value: '${transaction.amount! * 100000} INR'),
                  const SizedBox(height: 25),
                  const RowDetailWidget(title: 'Method', value: 'Cash Wallet'),
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
    );
  }

  Widget transactionFailedWidget(
      Transaction transaction, BuildContext context) {
    return Column(
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
                Icons.error_outline_rounded,
                size: 32,
                color: error,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Buy Not Completed',
              style: TextStyle(
                fontSize: title,
                color: text500,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${transaction.failType}',
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
                  'ID: ${transaction.id}',
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                      value: transaction.type.toString()),
                  const SizedBox(height: 25),
                  RowDetailWidget(
                      title: 'Rate', value: '${transaction.lockPrice} INR/gm'),
                  const SizedBox(height: 25),
                  RowDetailWidget(
                      title: 'Quantity', value: '${transaction.quantity} gm'),
                ],
              ),
            ),
            const SizedBox(height: 5),

            /// Total
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                          '${transaction.amount! * double.parse(transaction.lockPrice!)} INR'),
                  const SizedBox(height: 25),
                  RowDetailWidget(
                      title: 'Method', value: transaction.type.toString()),
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
    );
  }

  Widget transactionPendingWidget(
      Transaction transaction, BuildContext context) {
    return Column(
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
                Icons.watch_later_outlined,
                size: 32,
                color: warning,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Buy Not Completed',
              style: TextStyle(
                fontSize: title,
                color: text500,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${transaction.status}',
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
                  'ID: ${transaction.id}',
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                      value: transaction.type.toString()),
                  const SizedBox(height: 25),
                  RowDetailWidget(
                      title: 'Rate', value: '${transaction.lockPrice} INR/gm'),
                  const SizedBox(height: 25),
                  RowDetailWidget(
                      title: 'Quantity', value: '${transaction.quantity} gm'),
                ],
              ),
            ),
            const SizedBox(height: 5),

            /// Total
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                          '${transaction.amount! * int.parse(transaction.lockPrice!)} INR'),
                  const SizedBox(height: 25),
                  RowDetailWidget(
                      title: 'Method', value: transaction.type.toString()),
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
    );
  }
}
