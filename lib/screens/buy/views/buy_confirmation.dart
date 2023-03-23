import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasvat/screens/buy/bloc/buy_bloc.dart';
import '../../../utils/app_constants.dart';
import '../../../widgets/row_details_widget.dart';

class BuyConfirmationScreen extends StatefulWidget {
  final String quantity;
  const BuyConfirmationScreen({
    Key? key,
    required this.quantity,
  }) : super(key: key);
  @override
  State<BuyConfirmationScreen> createState() => _BuyConfirmationScreenState();
}

class _BuyConfirmationScreenState extends State<BuyConfirmationScreen>
    with TickerProviderStateMixin {

  @override
  void dispose() {
    context.read<BuyBloc>().clearTimer();
    context.read<BuyBloc>().close();
    super.dispose();
  }

  @override
  void initState() {
    context.read<BuyBloc>().addController(
      CustomTimerController(
        vsync: this,
        begin: const Duration(seconds: 0),
        end: const Duration(seconds: 300)
      )
    );

    // context.read<BuyBloc>().getController.

    context.read<BuyBloc>().getController.start();
    super.initState();
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
            Column(
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
                                    value: context.read<BuyBloc>()
                                    .getTransaction.type.toString()
                                  ),
                                const SizedBox(height: 25),
                                RowDetailWidget(
                                    title: 'Price/gram',
                                    value:
                                        '${['current_price']} INR/gm'),
                                const SizedBox(height: 25),
                                RowDetailWidget(
                                    title: 'Quantity',
                                    value: '${context.read<BuyBloc>()
                                    .getTransaction.quantity} gm'),
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
                                    value: '${context.read<BuyBloc>()
                                      .calculateAmountWithTax()
                                    } INR'),
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
                              controller: context.read<BuyBloc>().getController,
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

                                    /// confirm button
                                    const SizedBox(height: 20),
                                    // Condition for confirmation button
                                    if (state == CustomTimerState.counting)
                                      ElevatedButton(
                                        onPressed: () async {
                                          
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
                        ],
                      ),
                    ],
                  )
                ]
              )
            )
        );
  }
}
