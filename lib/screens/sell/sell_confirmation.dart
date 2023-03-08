import 'dart:convert';

import 'package:amplify_core/amplify_core.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/models/TransactionStatus.dart';
import 'package:tasvat/models/TransactionType.dart';
import 'package:tasvat/screens/sell/sell_completed_screen.dart';
import 'package:http/http.dart' as http;
import '../../models/Transaction.dart';
import '../../utils/app_constants.dart';
import '../../widgets/row_details_widget.dart';

class SellConfirmationScreen extends StatefulWidget {
  final String quantity;
  const SellConfirmationScreen({
    Key? key,
    required this.quantity,
  }) : super(key: key);

  @override
  State<SellConfirmationScreen> createState() => _SellConfirmationScreenState();
}

class _SellConfirmationScreenState extends State<SellConfirmationScreen>
    with TickerProviderStateMixin {
  late CustomTimerController _timerController;

  final Transaction buyOrderDetails = Transaction(
    id: '123456789',
    type: TransactionType.ADD,
    amount: 52,
    dateTime: TemporalDateTime(DateTime.now()),
    status: TransactionStatus.FAILED,
  );

  late http.Response reponse;

  /// calling safegold api for current pricing
  Future<http.Response> _getPriceData() async {
    // try {
    reponse = await http.get(
      Uri.parse('https://partners-staging.safegold.com/v1/buy-price'),
      headers: {
        'Authorization': 'Bearer 38778d59d5e17cfadc750e87703eb5e2',
      },
    );
    return reponse;
    // return http.Response;
    // }catch(e) {
    //
    // }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timerController.dispose();
    super.dispose();
  }

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
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Sell Confirmation',
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
                          value: buyOrderDetails.type.toString()),
                      const SizedBox(height: 25),
                      RowDetailWidget(title: 'Price', value: '${10000} INR/gm'),
                      const SizedBox(height: 25),
                      RowDetailWidget(
                          title: 'Amount',
                          value: '${buyOrderDetails.amount} gm'),
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
                          value: '${buyOrderDetails.amount! * 10000} INR'),
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
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Sell Confirmation',
                style: TextStyle(
                  fontSize: title,
                  color: text500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            FutureBuilder(
              future: _getPriceData(),
              builder: (context, AsyncSnapshot<http.Response> priceData) {
                if (priceData.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (priceData.data == null ||
                    priceData.hasError ||
                    !priceData.hasData ||
                    priceData.data!.statusCode == 500) {
                  return Center(
                    child: Text(
                      'Something Went Wroing. Check your internet speed and try again',
                      style: TextStyle(
                        fontSize: title,
                        color: text500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                } else if (priceData.data!.statusCode == 200) {
                  _timerController = CustomTimerController(
                    begin: const Duration(minutes: 7),
                    end: const Duration(seconds: 00),
                    initialState: CustomTimerState.reset,
                    interval: CustomTimerInterval.milliseconds,
                    vsync: this,
                  );

                  _timerController.start();

                  safePrint('price data = ${priceData.data}\n');
                  Map priceDataMap = jsonDecode(priceData.data!.body);
                  return Column(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        // mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                    value: buyOrderDetails.type.toString()),
                                const SizedBox(height: 25),
                                RowDetailWidget(
                                    title: 'Price/gram',
                                    value:
                                        '${priceDataMap['current_price']} INR/gm'),
                                const SizedBox(height: 25),
                                RowDetailWidget(
                                    title: 'Amount',
                                    value: '${widget.quantity} gm'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),

                          /// Total
                          Container(
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
                                  'Total',
                                  style: TextStyle(
                                      color: text300,
                                      fontSize: body2,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 25),
                                const RowDetailWidget(
                                    title: 'GST', value: '3 %'),
                                const SizedBox(height: 25),
                                RowDetailWidget(
                                    title: 'Final Price',
                                    value:
                                        '${_getTotal(rate: priceDataMap['current_price'])} INR'),
                                const SizedBox(height: 25),
                                const RowDetailWidget(
                                    title: 'Method', value: 'Cash Wallet'),
                              ],
                            ),
                          ),

                          /// timer 7 min
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: background,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: CustomTimer(
                              controller: _timerController,
                              builder: (CustomTimerState state,
                                  CustomTimerRemainingTime remaining) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            'Current Rate is valid for only  ',
                                        style: TextStyle(
                                          color: text400,
                                          fontSize: body1,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                '${remaining.minutes} : ${remaining.seconds} ',
                                            style: TextStyle(
                                              color: accent1,
                                              fontSize: heading2,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' minutes',
                                            style: TextStyle(
                                              color: text400,
                                              fontSize: body1,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 20),
                                    // Condition for confirmation button
                                    if (state == CustomTimerState.counting)
                                      ElevatedButton(
                                        onPressed: () {
                                          /// TODO: proceed to PAYMENTS SCREEN
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (ctx) =>
                                                  SellCompletedScreen(
                                                buyOrderDetails: Transaction(
                                                  id: '123456789',
                                                  type: TransactionType.SELL,
                                                  amount: 5,
                                                  dateTime: TemporalDateTime(
                                                      DateTime.now()),
                                                  status:
                                                      TransactionStatus.PENDING,
                                                ),
                                                backToHome: true,
                                              ),
                                            ),
                                            (route) => route.isFirst,
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          minimumSize:
                                              const Size(double.infinity, 50.0),
                                          maximumSize:
                                              const Size(double.infinity, 60.0),
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
                                  ],
                                );
                              },
                            ),
                          ),

                          /// confirm button
                        ],
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text(
                      'Something Went Wrong',
                      style: TextStyle(
                        fontSize: title,
                        color: text500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getTotal({required double rate}) {
    double ratei = rate;
    double quan = double.parse(widget.quantity);

    double total = ratei * quan * 1.03;
    // total.roundToDouble();
    return total.toStringAsFixed(4);
  }
}
