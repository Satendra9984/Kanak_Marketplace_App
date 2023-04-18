import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasvat/screens/sell/bloc/sell_bloc.dart';
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

class _SellConfirmationScreenState extends State<SellConfirmationScreen> {
  late SellBloc _sellBloc;

  @override
  void initState() {
    _sellBloc = context.read<SellBloc>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool choosing = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SellBloc, SellState>(
      listener: (context, state) {
        if (state.status == SellStatus.choose) {
          if (choosing) {
            return;
          }
          choosing = true;
          showModalBottomSheet<int>(
              context: context,
              builder: ((context) => BlocBuilder<SellBloc, SellState>(
                    builder: (context, state) {
                      return ListView.builder(
                          itemCount: state.banks!.length,
                          itemBuilder: ((context, index) => RadioListTile(
                              value: index,
                              title: Text(state.banks![index].ifscCode),
                              subtitle: Text(state.banks![index].accountNumber),
                              groupValue: state.chosenBank,
                              onChanged: (val) {
                                Navigator.pop(context, val);
                              }
                            )
                          )
                        );
                    },
                  ))).then((chosen) {
            choosing = false;
            chosen ??= state.chosenBank;
            _sellBloc.add(PaymentMethodChosen(chosen: chosen!));
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: background,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: background,
            ),
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
                                  Icon(state.chosenBank == 0
                                      ? Icons.wallet
                                      : Icons.account_balance),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      state.banks![state.chosenBank!].ifscCode),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    _sellBloc.add(ChoosePaymentMethod());
                                  },
                                  icon: const Icon(Icons.arrow_drop_down))
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // Proceed for Transaction
                            context.read<SellBloc>().add(
                                  ConfirmButtonPressed(),
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
            body: SingleChildScrollView(
              child: Column(
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
                                value: '${state.rates!.gSell} INR/gm'),
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
                              itemCount: state.rates!.taxes!.length,
                              itemBuilder: (context, index) {
                                return RowDetailWidget(
                                    title: state.rates!.taxes![index].type,
                                    value:
                                        '${state.rates!.taxes![index].taxPerc} %');
                              },
                            ),
                            const SizedBox(height: 25),
                            RowDetailWidget(
                                title: 'Equal',
                                value: '${state.transaction!.amount} INR'),
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
                        child: Column(
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
                                      text: '${state.remainingTime} Seconds',
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
                            ]),
                      ),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }
}
