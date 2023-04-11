import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/providers/user_provider.dart';
import 'package:tasvat/screens/buy/bloc/buy_bloc.dart';
import 'package:tasvat/screens/buy/views/buy_completed.dart';
import 'package:tasvat/screens/registration/bloc/registration_bloc.dart';
import '../../../services/datastore_services.dart';
import '../../../utils/app_constants.dart';
import '../../../widgets/row_details_widget.dart';

class BuyConfirmationScreen extends ConsumerStatefulWidget {
  const BuyConfirmationScreen({
    Key? key,
  }) : super(key: key);
  @override
  ConsumerState<BuyConfirmationScreen> createState() =>
      _BuyConfirmationScreenState();
}

class _BuyConfirmationScreenState extends ConsumerState<BuyConfirmationScreen> {
  late BuyBloc _buyBloc;

  @override
  void dispose() {
    safePrint('XXXXXXXXXXXXXXXXXXXXXXXXXX| Disposed');
    _buyBloc.closeTimer();
    _buyBloc.add(ResetEvent());
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  bool choosing = false;

  @override
  Widget build(BuildContext context) {
    _buyBloc = BlocProvider.of<BuyBloc>(context);
    return BlocConsumer<BuyBloc, BuyState>(
      listener: (context, state) {
        if (state.status == BuyStatus.choose) {
          if (choosing) {
            return;
          }
          choosing = true;
          showModalBottomSheet<PaymentMethod>(
              context: context,
              builder: ((context) => BlocBuilder<BuyBloc, BuyState>(
                    builder: (context, state) {
                      safePrint('.......${state.method}');
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: greyShade2,
                                borderRadius: BorderRadius.circular(13)),
                            child: RadioListTile(
                              value: 0,
                              groupValue:
                                  state.method == PaymentMethod.external
                                      ? 1
                                      : 0,
                              onChanged: (val) {
                                Navigator.pop(context, PaymentMethod.wallet);
                              },
                              title: Container(
                                  margin: const EdgeInsets.all(13),
                                  decoration: BoxDecoration(color: greyShade2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text('Wallet'),
                                    ],
                                  )),
                              secondary: const Icon(Icons.wallet),
                              subtitle: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(13, 0, 13, 13),
                                  child: const Text(
                                      'Choose to Pay from your Tasvat Wallet')),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: greyShade2,
                                borderRadius: BorderRadius.circular(13)),
                            child: RadioListTile(
                              value: 1,
                              groupValue: state.method ==
                                      PaymentMethod.external
                                  ? 1
                                  : 0,
                              onChanged: (val) {
                                _buyBloc.add(PaymentMethodChosen(
                                    method: PaymentMethod.external));
                                Navigator.pop(context, PaymentMethod.external);
                              },
                              title: Container(
                                  margin: const EdgeInsets.all(13),
                                  decoration: BoxDecoration(color: greyShade2),
                                  child: const Text(
                                    'External'
                                  )),
                              secondary: const Icon(Icons.account_balance),
                              subtitle: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(13, 0, 13, 13),
                                  child: const Text(
                                      'Use UPI, Netbanking, Credit or Debit Card')),
                            ),
                          )
                        ],
                      );
                    },
                  )
                )
              ).then((method) {
                choosing = false;
                method ??= state.method;
                _buyBloc.add(PaymentMethodChosen(method: method!));
              }
            );
        }
        if (state.status == BuyStatus.success ||
            state.status == BuyStatus.failed) {
          _buyBloc.closeTimer();

          ref.read(userProvider.notifier).syncDetails(user: _buyBloc.getUser);

          safePrint(
              '***************************${state.status}*******************************');
          safePrint(
              '***************************${state.transaction}*******************************');

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) =>
                  BuyCompletedScreen(transaction: state.transaction!),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: background,
            bottomNavigationBar: (state.remainingTime != 0)
                ? Container(
                    margin: const EdgeInsets.all(13),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(state.method == PaymentMethod.wallet ? Icons.wallet : Icons.account_balance),
                                  const SizedBox(width: 10,),
                                  Text(state.method.toString().split('.')[1] ==
                                          'external'
                                      ? 'External'
                                      : 'Wallet'),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    _buyBloc.add(ChoosePaymentMethod());
                                  },
                                  icon: const Icon(Icons.arrow_drop_down))
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // Proceed for Transaction
                            context.read<BuyBloc>().add(
                                  ConfirmButtonPressedEvent(),
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
                      ],
                    ),
                  )
                : null,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: background,
            ),
            body: state.status == BuyStatus.progress
                ? Center(
                    child: CircularProgressIndicator(color: accent2),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              value: state.transaction!.type
                                                  .toString()
                                                  .split('.')[1]
                                                  .toString()),
                                          const SizedBox(height: 25),
                                          RowDetailWidget(
                                              title: 'Price/gram',
                                              value:
                                                  '${state.transaction?.lockPrice} INR/gm'),
                                          const SizedBox(height: 25),
                                          RowDetailWidget(
                                              title: 'Quantity',
                                              value:
                                                  '${state.transaction?.quantity} gm'),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                  '${state.transaction?.amount} INR'),
                                          const SizedBox(height: 25),
                                          // const RowDetailWidget(
                                          //     title: 'Method', value: 'Cash Wallet'),
                                        ],
                                      ),
                                    ),

                                    /// timer 180 sec
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 20),
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: background,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                        '${state.remainingTime}',
                                                    style: TextStyle(
                                                      color: accent1,
                                                      fontSize: heading2,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' minutes',
                                                    style: TextStyle(
                                                      color: text400,
                                                      fontSize: body1,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            /// confirm button
                                            const SizedBox(height: 20),
                                            // Condition for confirmation button
                                          ],
                                        )),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ));
      },
    );
  }
}
