import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/utils/app_constants.dart';
import 'package:tasvat/models/transaction_model.dart';
import 'package:tasvat/screens/sell/sell_confirmation.dart';
import 'package:tasvat/screens/withdraw/select_time_&_vendor.dart';

class WithdrawAssets extends StatelessWidget {
  WithdrawAssets({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _textEditingController = TextEditingController();

  String _getTotal() {
    double? tryQuantity = double.tryParse(_textEditingController.text);
    double quantity = tryQuantity ?? 0.00;
    return (quantity * 300.00).toString();
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
        alignment: Alignment.topCenter,
        child: Form(
          key: _formKey,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),

              /// buy amount
              Text(
                'Sell Amount',
                style: TextStyle(
                  fontSize: body2,
                  color: text300,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 35),
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
                  } else if (controller != null && controller.text.isEmpty) {
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
                        // mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // TODO : INPUT FOR BUY AMOUNT
                                children: [
                                  Container(
                                    height: 60,
                                    width: 120,
                                    alignment: Alignment.bottomCenter,
                                    child: TextField(
                                      onChanged: (value) {
                                        // _textEditingController.text = value;
                                        formState
                                            .didChange(_textEditingController);
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
                                    'mace',
                                    style: TextStyle(
                                      fontSize: body2,
                                      color: text400,
                                      fontWeight: FontWeight.w500,
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
                          Text(
                            formState.isValid
                                ? '~ ${_getTotal()} USD'
                                : '~ 0.00 USD',
                            style: TextStyle(
                              fontSize: body2,
                              color: text400,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /// CASH BALANCE
                              Text(
                                'Gold Balance: 30.0 mace',
                                style: TextStyle(
                                  fontSize: body2,
                                  color: text300,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 15),
                              ElevatedButton(
                                onPressed: () {
                                  /// proceed to buy
                                  if (_formKey.currentState != null &&
                                      _formKey.currentState!.validate()) {
                                    closeKeyboard(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) => SelectTimeAndVendor(
                                          buyOrderDetails: Transaction(
                                            activityName: 'Sell',
                                            quantity: double.parse(
                                                _textEditingController.text),
                                            date: '28/01/2023',
                                            time: '16:00',
                                            price: 300.00,
                                          ),
                                          id: '1',
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
