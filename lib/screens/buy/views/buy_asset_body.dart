import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:tasvat/providers/gold_rate_provider.dart';
import 'package:tasvat/providers/user_provider.dart';
import 'package:tasvat/screens/buy/bloc/buy_bloc.dart';
import 'package:tasvat/screens/gold_rates/gold_rate_graph.dart';
import '../../../utils/app_constants.dart';
import 'buy_confirmation.dart';

class BuyAssetBody extends ConsumerStatefulWidget {
  final Map<String, dynamic> goldApiRateData;
  const BuyAssetBody({
    Key? key,
    required this.goldApiRateData,
  }) : super(key: key);

  @override
  ConsumerState<BuyAssetBody> createState() => _BuyAssetBodyState();
}

class _BuyAssetBodyState extends ConsumerState<BuyAssetBody>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  bool _openAmountOptions = true, _openQuantityOptions = true;

  void _setValues({required double goldRate, bool byAmount = true}) {
    if (byAmount) {
      double amount = 0.0;
      if (_amountController.text.isNotEmpty) {
        amount = double.parse(_amountController.text);
      }
      if (amount != 0.0) {
        debugPrint(amount.toStringAsFixed(4));
        setState(() {
          _qtyController.text = (amount / goldRate).toStringAsFixed(4);
        });
      } else {
        setState(() {
          _qtyController.text = '0.0';
        });
      }
    } else {
      double quantity = 0.0;
      if (_qtyController.text.isNotEmpty) {
        quantity = double.parse(_qtyController.text);
      }
      setState(() {
        _amountController.text = (quantity * goldRate).toStringAsFixed(4);
      });
    }
  }

  void _addAmountFromOptions(
      {required String amountS, required FormFieldState state}) {
    // debugPrint(_amountController.text);
    double amount = 0.0;
    if (_amountController.text.isNotEmpty) {
      amount = double.parse(_amountController.text);
    }
    amount += double.parse(amountS);
    // double totalA = amount * currentPrice;
    _amountController.text = amount.toStringAsFixed(4);
    _setValues(goldRate: widget.goldApiRateData['current_price']);
    state.didChangeDependencies();
  }

  void _addQuantityFromOptions(
      {required String qtyS, required FormFieldState state}) {
    double qty = 0.0;
    if (_qtyController.text.isNotEmpty) {
      qty = double.parse(_qtyController.text);
    }
    qty += double.parse(qtyS);

    _qtyController.text = qty.toStringAsFixed(4);
    _setValues(
        goldRate: widget.goldApiRateData['current_price'], byAmount: false);
    state.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const GoldRateGraph(),
                const SizedBox(height: 25),
                Text(
                  'Live Gold Rate: ${widget.goldApiRateData['current_price']} ₹',
                  style: TextStyle(
                    fontSize: heading2,
                    color: text500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                FormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: _amountController,
                  validator: (controller) {
                    if (controller != null && controller.text.isNotEmpty) {
                      double? isDouble = double.tryParse(controller.text);
                      if (isDouble != null) {
                        return null;
                      }
                      return 'Invalid Input';
                    } else if (controller != null && controller.text.isEmpty) {
                      return 'Enter Amount';
                    }
                    return null;
                  },
                  builder: (formState) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Expanded(
                                flex: 8,
                                child: Text(
                                  'Amount (₹)',
                                  style: TextStyle(
                                    fontSize: body1,
                                    color: text400,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _openAmountOptions = !_openAmountOptions;
                                  });
                                },
                                icon: const Icon(
                                  Icons.keyboard_option_key,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: TextField(
                                  onChanged: (value) {
                                    _setValues(
                                      goldRate: widget
                                          .goldApiRateData['current_price'],
                                    );
                                    formState.didChange(_amountController);
                                  },
                                  maxLines: 1,
                                  textAlign: TextAlign.end,
                                  textAlignVertical: TextAlignVertical.top,
                                  controller: _amountController,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: accent2,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    fillColor: accentBG.withOpacity(0.55),
                                    filled: true,
                                    focusColor: accentBG.withOpacity(0.55),
                                    // enabledBorder: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    isDense: true,
                                    hintText: '0.0',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: accent1.withOpacity(0.6),
                                    ),
                                    labelStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: text200,
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                          if (_openAmountOptions)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _addAmountFromOptions(
                                        amountS: '1000.0', state: formState);
                                  },
                                  child: Text('+1000', style: _optionsStyle),
                                ),
                                TextButton(
                                    onPressed: () {
                                      _addAmountFromOptions(
                                          amountS: '5000.0', state: formState);
                                    },
                                    child: Text('+5000', style: _optionsStyle)),
                                TextButton(
                                    onPressed: () {
                                      _addAmountFromOptions(
                                          amountS: '10000.0', state: formState);
                                    },
                                    child:
                                        Text('+10000', style: _optionsStyle)),
                              ],
                            ),
                          if (formState.hasError)
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Text(
                                '${formState.errorText}',
                                style: TextStyle(
                                  fontSize: body2,
                                  color: error,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                FormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: _qtyController,
                  validator: (controller) {
                    if (controller != null && controller.text.isNotEmpty) {
                      double? isDouble = double.tryParse(controller.text);
                      if (isDouble != null) {
                        return null;
                      }
                      return 'Invalid Input';
                    } else if (controller != null && controller.text.isEmpty) {
                      return 'Enter Quantity';
                    }
                    return null;
                  },
                  builder: (formState) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Expanded(
                                flex: 8,
                                child: Text(
                                  'Quantity (gram)',
                                  style: TextStyle(
                                    fontSize: body1,
                                    color: text400,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _openQuantityOptions =
                                        !_openQuantityOptions;
                                  });
                                },
                                icon: const Icon(
                                  Icons.keyboard_option_key,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: TextField(
                                  onChanged: (value) {
                                    _setValues(
                                        goldRate: widget
                                            .goldApiRateData['current_price'],
                                        byAmount: false);
                                    formState.didChange(_qtyController);
                                  },
                                  maxLines: 1,
                                  textAlign: TextAlign.end,
                                  textAlignVertical: TextAlignVertical.top,
                                  controller: _qtyController,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: accent2,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    fillColor: accentBG.withOpacity(0.55),
                                    filled: true,
                                    focusColor: accentBG.withOpacity(0.55),
                                    // enabledBorder: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    isDense: true,
                                    hintText: '0.0',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: accent1.withOpacity(0.6),
                                    ),
                                    labelStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: text200,
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                          if (_openQuantityOptions)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      _addQuantityFromOptions(
                                          qtyS: '1', state: formState);
                                    },
                                    child: Text('+1gm', style: _optionsStyle)),
                                TextButton(
                                    onPressed: () {
                                      _addQuantityFromOptions(
                                          qtyS: '5', state: formState);
                                    },
                                    child: Text('+5', style: _optionsStyle)),
                                TextButton(
                                    onPressed: () {
                                      _addQuantityFromOptions(
                                          qtyS: '10', state: formState);
                                    },
                                    child: Text('+10', style: _optionsStyle)),
                                TextButton(
                                    onPressed: () {
                                      _addQuantityFromOptions(
                                          qtyS: '100', state: formState);
                                    },
                                    child: Text('+100', style: _optionsStyle)),
                              ],
                            ),
                          if (formState.hasError)
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Text(
                                '${formState.errorText}',
                                style: TextStyle(
                                  fontSize: body2,
                                  color: error,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),

            /// cash balance and button
            Container(
              margin: const EdgeInsets.only(
                  left: 15, right: 15, top: 5, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// CASH BALANCE
                  Text(
                    'Cash Balance : ${user?.wallet?.balance ?? '--'} ₹',
                    style: TextStyle(
                      fontSize: body2,
                      color: text300,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SwipeButton.expand(
                      thumb: const Icon(
                        Icons.double_arrow_rounded,
                        color: Colors.green,
                      ),
                      activeThumbColor: accent2,
                      activeTrackColor: accentBG,
                      onSwipe: () async {
                        closeKeyboard(context);
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          // PROCEED TO CONFIRMATION SCREEN
                          await ref
                              .read(goldRateProvider.notifier)
                              .updateRates()
                              .then(
                            (value) {
                              final rate = ref.read(goldRateProvider);
                              debugPrint(rate.gBuy);
                              context.read<BuyBloc>().add(RateConfirmEvent(
                                  user: ref.read(userProvider)!,
                                  exchangeRates: rate,
                                  quantity: double.parse(_qtyController.text)));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) =>
                                      const BuyConfirmationScreen(),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Text(
                        "Continue ...",
                        style: TextStyle(
                          color: background,
                          fontSize: body1,
                          fontWeight: FontWeight.w600,
                        ),
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

  closeKeyboard(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  final TextStyle _optionsStyle = const TextStyle(
    color: Colors.green,
  );
}
