import 'package:amplify_core/amplify_core.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/models/TransactionStatus.dart';
import 'package:tasvat/models/TransactionType.dart';
import 'package:tasvat/models/gold_models/rate_model.dart';
import 'package:tasvat/screens/sell/views/sell_completed_screen.dart';
import 'package:http/http.dart' as http;
import 'package:tasvat/services/gold_services.dart';
import '../../../models/Transaction.dart';
import '../../../utils/app_constants.dart';
import '../../../widgets/row_details_widget.dart';

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

  /// Calling safe-gold api for current pricing
  Future<ExchangeRates?> _getPriceData() async {
    try {
      ExchangeRates? exchangeRates = await GoldServices.getMetalsRate();
      if (exchangeRates == null) {
        throw Exception('Something Went Wrong');
      }
      return exchangeRates;
    } catch (e) {
      rethrow;
    }
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
      body: FutureBuilder(
        future: _getPriceData(),
        builder: (context, AsyncSnapshot<ExchangeRates?> priceData) {
          if (priceData.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (priceData.data == null || priceData.hasError) {
            return Center(
              child: Text(
                'Something Went Wrong. Try again',
                style: TextStyle(
                  fontSize: title,
                  color: text500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          } else if (priceData.data! != null) {
            _timerController = CustomTimerController(
              begin: const Duration(minutes: 2),
              end: const Duration(seconds: 00),
              initialState: CustomTimerState.reset,
              interval: CustomTimerInterval.milliseconds,
              vsync: this,
            );

            _timerController.start();

            return Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          const RowDetailWidget(
                              title: 'Transaction Type', value: 'Sell'),
                          const SizedBox(height: 25),
                          RowDetailWidget(
                              title: 'Price',
                              value: '${priceData.data!.gSell} INR/gm'),
                          const SizedBox(height: 25),
                          RowDetailWidget(
                              title: 'Amount', value: '${widget.quantity} gm'),
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

                          /// Taxes
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: priceData.data!.taxes!.length,
                            itemBuilder: (context, index) {
                              return RowDetailWidget(
                                  title: priceData.data!.taxes![index].type,
                                  value:
                                      '${priceData.data!.taxes![index].taxPerc} %');
                            },
                          ),
                          const SizedBox(height: 25),
                          RowDetailWidget(
                              title: 'Equal',
                              value:
                                  '${_getTotal(taxes: priceData.data!.taxes!, price: priceData.data!.gSell!)} INR'),
                          const SizedBox(height: 25),
                        ],
                      ),
                    ),

                    /// confirm button
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
                                  text: 'Current Rate is valid for only  ',
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
                                    /// proceed to PAYMENTS SCREEN
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) => SellCompletedScreen(
                                          rateData: priceData.data!,
                                          amount: double.parse(_getTotal(
                                              taxes: priceData.data!.taxes!,
                                              price: priceData.data!.gSell!)),
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
    );
  }

  String _getTotal({required List<Tax> taxes, required String price}) {
    double quantity = double.parse(widget.quantity);
    double priceD = double.parse(price);
    double total = quantity * priceD;
    for (Tax tax in taxes) {
      total *= (1 + double.parse(tax.taxPerc));
    }

    String totalS = total.toStringAsFixed(4);

    return totalS;
  }
}
