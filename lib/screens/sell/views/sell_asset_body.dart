import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/models/BankAccount.dart';
import 'package:tasvat/models/gold_models/bank_response.dart';
import 'package:tasvat/providers/gold_rate_provider.dart';
import 'package:tasvat/providers/inhouse_account_provider.dart';
import 'package:tasvat/screens/sell/bloc/sell_bloc.dart';
import 'package:tasvat/screens/sell/views/sell_confirmation.dart';
import 'package:tasvat/services/gold_services.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/app_constants.dart';

class SellAssetBody extends ConsumerStatefulWidget {
  final Map<String, dynamic> goldApiRateData;

  const SellAssetBody({
    Key? key,
    required this.goldApiRateData,
  }) : super(key: key);

  @override
  ConsumerState<SellAssetBody> createState() => _SellAssetBodyState();
}

class _SellAssetBodyState extends ConsumerState<SellAssetBody> {
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

  void _addAmountFromOptions({required String amountS}) {
    // debugPrint(_amountController.text);
    double amount = 0.0;
    if (_amountController.text.isNotEmpty) {
      amount = double.parse(_amountController.text);
    }
    amount += double.parse(amountS);
    // double totalA = amount * currentPrice;
    _amountController.text = amount.toStringAsFixed(4);
    _setValues(goldRate: widget.goldApiRateData['current_price']);
  }

  void _addQuantityFromOptions({required String qtyS}) {
    double qty = 0.0;
    if (_qtyController.text.isNotEmpty) {
      qty = double.parse(_qtyController.text);
    }
    qty += double.parse(qtyS);

    _qtyController.text = qty.toStringAsFixed(4);
    _setValues(
        goldRate: widget.goldApiRateData['current_price'], byAmount: false);
  }

  @override
  void initState() {
    // TODO: implement initState
    // _amountController.text = '0.0';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BankAccount? bank = ref.watch(userProvider)!.bankAccounts?[0];
    safePrint(bank);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (bank == null)
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      color: text100,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.error, color: error),
                      title: Text(
                        'You don\'t have a Bank Account',
                        style: TextStyle(
                          fontSize: body1,
                          color: error,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        'Profile -> Bank Accounts -> Add',
                        style: TextStyle(
                          fontSize: body2,
                          color: text500,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      dense: true,
                    ),
                  ),
                const SizedBox(height: 15),
                ClipRRect(
                  child: Image.asset(
                    'assets/images/coin.png',
                    height: 80,
                    width: 60,
                  ),
                ),
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
                                    _addAmountFromOptions(amountS: '1000.0');
                                  },
                                  child: Text('+1000', style: _optionsStyle),
                                ),
                                TextButton(
                                    onPressed: () {
                                      _addAmountFromOptions(amountS: '5000.0');
                                    },
                                    child: Text('+5000', style: _optionsStyle)),
                                TextButton(
                                    onPressed: () {
                                      _addAmountFromOptions(amountS: '10000.0');
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
                                      _addQuantityFromOptions(qtyS: '1');
                                    },
                                    child: Text('+1gm', style: _optionsStyle)),
                                TextButton(
                                    onPressed: () {
                                      _addQuantityFromOptions(qtyS: '5');
                                    },
                                    child: Text('+5', style: _optionsStyle)),
                                TextButton(
                                    onPressed: () {
                                      _addQuantityFromOptions(qtyS: '10');
                                    },
                                    child: Text('+10', style: _optionsStyle)),
                                TextButton(
                                    onPressed: () {
                                      _addQuantityFromOptions(qtyS: '100');
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
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// CASH BALANCE
                Text(
                  'Gold Balance : 20 grams',
                  style: TextStyle(
                    fontSize: body2,
                    color: text400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    // PROCEED TO BUY
                    closeKeyboard(context);
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate() &&
                        bank != null) {
                      await ref
                          .read(goldRateProvider.notifier)
                          .updateRates()
                          .then((rate) {
                            final user = ref.read(userProvider);
                        context.read<SellBloc>().add(
                          SellConfirmEvent(
                            rates: ref.read(goldRateProvider),
                            quantity: double.parse(_qtyController.text),
                            user: user!,
                            banks: [ref.read(inhouseAccountProvider)!, ...user.bankAccounts!.map((acc) => UserBank.fromJson({
                              'userBankId': acc.bankId,
                              'uniqueId': acc.userID,
                              'accountNumber': acc.accNo,
                              'accountName': acc.accName,
                              'ifscCode': acc.ifsc,
                              'status': acc.status
                            })).toList()]
                          ));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => SellConfirmationScreen(
                              quantity: _qtyController.text,
                            ),
                          ),
                        );
                      });
                      // PROCEED TO CONFIRMATION SCREEN
                    }
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
                    'Continue',
                    style: TextStyle(
                      color: background,
                      fontSize: heading2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
