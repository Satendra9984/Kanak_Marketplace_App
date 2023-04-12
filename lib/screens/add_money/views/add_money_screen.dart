import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/providers/user_provider.dart';
import '../../../models/User.dart';
import '../../../utils/app_constants.dart';

class AddMoneyScreen extends ConsumerStatefulWidget {
  const AddMoneyScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends ConsumerState<AddMoneyScreen> {
  final TextEditingController _amountCtrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _addAmountFromOptions({required String amountS}) {
    // debugPrint(_amountController.text);
    double amount = 0.0;
    if (_amountCtrl.text.isNotEmpty) {
      amount = double.parse(_amountCtrl.text);
    }
    amount += double.parse(amountS);
    // double totalA = amount * currentPrice;
    _amountCtrl.text = amount.toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User user = ref.watch(userProvider)!;
    return WillPopScope(
      onWillPop: () async {
        // Size size = MediaQuery.of(context).size;
        // debugPrint('sizebeforekey: ${size.height}');
        closeKeyboard(context);
        // await Future.delayed(const Duration(seconds: 1));
        // debugPrint('sizeafterkey: ${size.height}');

        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: background,
          elevation: 0.0,
          title: const Text('Add money'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Container(
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      '${user.wallet?.balance} ₹ available',
                      style: TextStyle(
                        fontSize: body1,
                        color: text400,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    FormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: _amountCtrl,
                      validator: (controller) {
                        if (controller != null && controller.text.isNotEmpty) {
                          double? isDouble = double.tryParse(controller.text);
                          if (isDouble != null) {
                            return null;
                          }
                          return 'Invalid Input';
                        } else if (controller != null &&
                            controller.text.isEmpty) {
                          return 'Enter Amount';
                        }
                        return null;
                      },
                      builder: (formState) {
                        return Container(
                          // color: Colors.red,
                          margin: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    'Amount (₹)',
                                    style: TextStyle(
                                      fontSize: body1,
                                      color: text400,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 190,
                                        child: TextField(
                                          onChanged: (value) {},
                                          onEditingComplete: () {},
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          textAlignVertical:
                                              TextAlignVertical.top,
                                          controller: _amountCtrl,
                                          focusNode: _focusNode,
                                          autofocus: true,
                                          style: TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.w400,
                                              color: accent2),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 8),
                                            fillColor: background,
                                            filled: true,
                                            focusColor: null,
                                            focusedBorder: InputBorder.none,
                                            border: InputBorder.none,
                                            isDense: true,
                                            hintText: '0.0',
                                            hintStyle: TextStyle(
                                                fontSize: 32,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    accent1.withOpacity(0.6)),
                                            labelStyle: TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.w400,
                                              color: text200,
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                      // IconButton(
                                      //     onPressed: () {
                                      //       _amountCtrl.text = '';
                                      //     },
                                      //     icon: const Icon(Icons.cancel)),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      _addAmountFromOptions(amountS: '1000.0');
                                    },
                                    child: Text('+1000', style: _optionsStyle),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        _addAmountFromOptions(
                                            amountS: '5000.0');
                                      },
                                      child:
                                          Text('+5000', style: _optionsStyle)),
                                  TextButton(
                                      onPressed: () {
                                        _addAmountFromOptions(
                                            amountS: '10000.0');
                                      },
                                      child:
                                          Text('+10000', style: _optionsStyle)),
                                ],
                              ),
                              if (formState.hasError)
                                Container(
                                  // color: Colors.green,
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
                    const SizedBox(height: 30),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 10),
                      child: ElevatedButton(
                        onPressed: () async {
                          // PROCEED TO BUY
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
                          'Add',
                          style: TextStyle(
                            color: background,
                            fontSize: heading2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  final TextStyle _optionsStyle = TextStyle(
    color: text500,
    fontSize: body1,
    fontWeight: FontWeight.w400,
  );
  void closeKeyboard(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.dispose();
    super.dispose();
  }
}
