import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasvat/utils/app_constants.dart';
import 'package:tasvat/screens/buy/buy_confirmation.dart';
import 'package:http/http.dart' as http;

class BuyAssets extends StatefulWidget {
  const BuyAssets({Key? key}) : super(key: key);

  @override
  State<BuyAssets> createState() => _BuyAssetsState();
}

class _BuyAssetsState extends State<BuyAssets> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _buyTypeString = 'Buy Amount';
  BuyType _buyType = BuyType.buyByAmount;
  final TextEditingController _textEditingController = TextEditingController();

  Stream<http.Response> _getPriceDataStream() async* {
    // try {
    yield* Stream.periodic(const Duration(seconds: 5), (_) {
      return http.get(
        Uri.parse('https://partners-staging.safegold.com/v1/buy-price'),
        headers: {
          'Authorization': 'Bearer 38778d59d5e17cfadc750e87703eb5e2',
        },
      );
    }).asyncMap((event) async => await event);

    // return http.Response;
    // }catch(e) {
    //
    // }
  }

  String _getTotal({required double current_rate}) {
    // double rate = double.parse(current_rate);
    if (_buyType == BuyType.buyByQuantity) {
      double? tryQuantity = double.tryParse(_textEditingController.text);
      double quantity = tryQuantity ?? 0.00;
      return (quantity * current_rate).toStringAsFixed(4);
    } else {
      return _textEditingController.text;
    }
  }

  String _getTotalGold({required double current_rate}) {
    if (_buyType == BuyType.buyByAmount) {
      double? tryQuantity = double.tryParse(_textEditingController.text);
      double quantity = tryQuantity ?? 0.00;
      if (quantity != 0.0) {
        return (quantity / current_rate).toStringAsFixed(4);
      }
      return '0.0';
    } else {
      return _textEditingController.text;
    }
  }

  void addAmount() {}

  void setBuyType(BuyType buyType) {
    debugPrint('$buyType');
    if (buyType == BuyType.buyByAmount) {
      setState(() {
        _buyTypeString = 'Buy Amount';
        _buyType = BuyType.buyByAmount;
      });
    } else if (buyType == BuyType.buyByQuantity) {
      setState(() {
        _buyTypeString = 'Buy Quantity';
        _buyType = BuyType.buyByQuantity;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _textEditingController.text = '0.0';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0.0,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: StreamBuilder(
            stream: _getPriceDataStream(),
            builder: (context, AsyncSnapshot<http.Response> response) {
              if (response.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (response.hasError) {
                return const Text('Something went wrong');
              }
              debugPrint(response.data!.body);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PopupMenuButton<BuyType>(
                        onSelected: (buyType) {
                          setBuyType(buyType);
                        },
                        itemBuilder: (ctx) {
                          return [
                            PopupMenuItem(
                              value: BuyType.buyByAmount,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Buy By Amount',
                                    style: TextStyle(
                                      fontSize: heading2,
                                      color: text500,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(
                                    Icons.currency_rupee_rounded,
                                    color: accent2,
                                  )
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: BuyType.buyByQuantity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Buy by Quantity',
                                    style: TextStyle(
                                      fontSize: heading2,
                                      color: text500,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(
                                    Icons.line_weight,
                                    color: accent2,
                                  )
                                ],
                              ),
                            ),
                          ];
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: text150,
                        // icon:
                        child: Row(
                          children: [
                            Text(
                              _buyTypeString,
                              style: TextStyle(
                                fontSize: body1,
                                color: text400,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Current Rate: ${jsonDecode(response.data!.body)['current_price']}',
                    style: TextStyle(
                      fontSize: heading2,
                      color: text500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  FormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: _textEditingController,
                    validator: (controller) {
                      if (controller != null && controller.text.isNotEmpty) {
                        double? isDouble = double.tryParse(controller.text);
                        if (isDouble != null) {
                          return null;
                        }
                        return 'Invalid Input';
                      } else if (controller != null &&
                          controller.text.isEmpty) {
                        return 'Enter Quantity';
                      }
                      return null;
                    },
                    builder: (formState) {
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // TODO : INPUT FOR BUY AMOUNT
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 120,
                                        alignment: Alignment.bottomCenter,
                                        child: TextField(
                                          onChanged: (value) {
                                            formState.didChange(
                                                _textEditingController);
                                          },
                                          textAlign: TextAlign.end,
                                          textAlignVertical:
                                              TextAlignVertical.bottom,
                                          controller: _textEditingController,
                                          style: TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.w600,
                                            color: accent2,
                                          ),
                                          decoration: InputDecoration(
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.all(0.0),
                                            isDense: true,
                                            alignLabelWithHint: true,
                                            hintText: '0.0',
                                            hintStyle: TextStyle(
                                              fontSize: 50,
                                              fontWeight: FontWeight.w500,
                                              color: text200,
                                            ),
                                            labelStyle: TextStyle(
                                              fontSize: 50,
                                              fontWeight: FontWeight.w500,
                                              color: text200,
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 60,
                                        child: VerticalDivider(
                                          thickness: 2.5,
                                          color: accent2.withOpacity(0.6),
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        _buyType == BuyType.buyByAmount
                                            ? '₹'
                                            : 'gram',
                                        style: TextStyle(
                                          fontSize:
                                              _buyType == BuyType.buyByAmount
                                                  ? heading1
                                                  : body1,
                                          color: text400,
                                          fontWeight:
                                              _buyType == BuyType.buyByAmount
                                                  ? FontWeight.w400
                                                  : FontWeight.w600,
                                        ),
                                      ),
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
                              if (_buyType == BuyType.buyByAmount)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        double amount = double.parse(
                                            _textEditingController.text ??
                                                '0.0');
                                        amount += 100;
                                        _textEditingController.text =
                                            amount.toStringAsFixed(4);
                                      },
                                      child: const Text('+100'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        double amount = double.parse(
                                            _textEditingController.text ??
                                                '0.0');
                                        amount += 500;
                                        _textEditingController.text =
                                            amount.toStringAsFixed(4);
                                      },
                                      child: const Text('+500'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        double amount = double.parse(
                                            _textEditingController.text ??
                                                '0.0');
                                        amount += 10000;
                                        _textEditingController.text =
                                            amount.toStringAsFixed(4);
                                      },
                                      child: const Text('+10000'),
                                    )
                                  ],
                                ),
                              if (_buyType == BuyType.buyByQuantity)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        double amount = double.parse(
                                            _textEditingController.text ??
                                                '0.0');
                                        amount += 100;
                                        _textEditingController.text =
                                            amount.toStringAsFixed(4);
                                      },
                                      child: const Text('+100'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        double amount = double.parse(
                                            _textEditingController.text ??
                                                '0.0');
                                        amount += 500;
                                        _textEditingController.text =
                                            amount.toStringAsFixed(4);
                                      },
                                      child: const Text('+500'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        double amount = double.parse(
                                            _textEditingController.text ??
                                                '0.0');
                                        amount += 10000;
                                        _textEditingController.text =
                                            amount.toStringAsFixed(4);
                                      },
                                      child: const Text('+10000'),
                                    )
                                  ],
                                ),
                              Text(
                                formState.isValid
                                    ? '~ ${_getTotal(
                                        current_rate:
                                            jsonDecode(response.data!.body)[
                                                'current_price'],
                                      )} ₹'
                                    : '~ 0.00 ₹',
                                style: TextStyle(
                                  fontSize: heading1,
                                  color: text400,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                formState.isValid
                                    ? '~ ${_getTotalGold(
                                        current_rate:
                                            jsonDecode(response.data!.body)[
                                                'current_price'],
                                      )} gm'
                                    : '~ 0.00 gm',
                                style: TextStyle(
                                  fontSize: heading1,
                                  color: text400,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /// CASH BALANCE
                                  Text(
                                    'Cash Balance: 12,000.00 ₹',
                                    style: TextStyle(
                                      fontSize: body2,
                                      color: text300,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      // PROCEED TO BUY
                                      closeKeyboard(context);
                                      if (_formKey.currentState != null &&
                                          _formKey.currentState!.validate()) {
                                        // PROCEED TO CONFIRMATION SCREEN
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (ctx) =>
                                                BuyConfirmationScreen(
                                              quantity:
                                                  _textEditingController.text,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      minimumSize:
                                          const Size(double.infinity, 50.0),
                                      maximumSize:
                                          const Size(double.infinity, 60.0),
                                      backgroundColor:
                                          formState.isValid ? accent1 : text200,
                                    ),
                                    child: Text(
                                      'Continue',
                                      style: TextStyle(
                                        color: formState.isValid
                                            ? background
                                            : text300,
                                        fontSize: heading2,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
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
}

enum BuyType {
  buyByAmount,
  buyByQuantity,
}
