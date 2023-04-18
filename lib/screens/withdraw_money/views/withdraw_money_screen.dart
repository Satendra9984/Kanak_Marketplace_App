import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/providers/user_provider.dart';
import 'package:tasvat/services/datastore_services.dart';
import '../../../models/User.dart';
import '../../../utils/app_constants.dart';
import '../bloc/withdraw_money_bloc.dart';

class WithdrawMoneyScreen extends ConsumerStatefulWidget {
  const WithdrawMoneyScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<WithdrawMoneyScreen> createState() =>
      _WithdrawMoneyScreenState();
}

class _WithdrawMoneyScreenState extends ConsumerState<WithdrawMoneyScreen> {
  final TextEditingController _amountCtrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey();
  late double _availableAmount;

  Future<void> _withdrawMoney() async {
    User user = ref.read(userProvider)!;
    double balance = user.wallet!.balance!;

    // TODO: TRANSACTION MODEL
    Transaction transaction = Transaction(
      userId: user.id,
      type: TransactionType.,
      balance: balance - _availableAmount,
    );

    /// PENDING TRANSACTION REQUEST
    await DatastoreServices.addPendingTransaction(transaction: transaction)
        .then((tran1) async {
      // TODO: MARK SUCCESSFUL / FAILED
      await DatastoreServices.updateWalletBalance(
        wallet: user.wallet!,
        balance: balance - _availableAmount,
      ).then((updatedWallet) {
        if (updatedWallet == null) {
          return;
        }
        ref
            .read(userProvider.notifier)
            .updateWalletBalance(wallet: updatedWallet);
        // Navigator.push(context, MaterialPageRoute(builder: (ctx){
        //   return
        // }));
      });
    });
  }

  void _addAmountFromOptions({required String amountS}) {
    double amount = 0.0;
    if (_amountCtrl.text.isNotEmpty) {
      amount = double.parse(_amountCtrl.text);
    }
    amount += double.parse(amountS);
    _amountCtrl.text = amount.toStringAsFixed(2);
  }

  @override
  void initState() {
    _availableAmount = ref.watch(userProvider)!.wallet!.balance ?? 0.0;
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
          title: const Text('Withdraw money'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Form(
            key: _formKey,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
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
                          if (isDouble == null) {
                            return 'Enter valid amount';
                          } else if (isDouble > _availableAmount) {
                            return 'Amount not available';
                          }
                          return null;
                        } else if (controller != null &&
                            controller.text.isEmpty) {
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
                              Column(
                                mainAxisSize: MainAxisSize.min,
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
                                          onChanged: (value) {
                                            setState(() {
                                              _amountCtrl.text = value;
                                            });
                                            formState.didChange(_amountCtrl);
                                          },
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
                                      _addAmountFromOptions(
                                        amountS: '1000.0',
                                      );
                                      formState.didChange(_amountCtrl);
                                    },
                                    child: Text('-1000', style: _optionsStyle),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        _addAmountFromOptions(
                                            amountS: '5000.0');
                                        formState.didChange(_amountCtrl);
                                      },
                                      child:
                                          Text('-5000', style: _optionsStyle)),
                                  TextButton(
                                      onPressed: () {
                                        _addAmountFromOptions(
                                            amountS: '10000.0');
                                        formState.didChange(_amountCtrl);
                                      },
                                      child:
                                          Text('-10000', style: _optionsStyle)),
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
                          if (_formKey.currentState!.validate()) {
                            // User user = ref.read(userProvider)!;
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
