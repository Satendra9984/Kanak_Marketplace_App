import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/models/function_lifetime_enum.dart';
import 'package:tasvat/providers/user_provider.dart';
import 'package:tasvat/services/gold_services.dart';
import '../../../../models/BankAccount.dart';
import '../../../../models/User.dart';
import '../../../../services/datastore_services.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/ui_functions.dart';

class UpdateUserBankDetailsPage extends ConsumerStatefulWidget {
  final BankAccount bankAccount;
  const UpdateUserBankDetailsPage({
    super.key,
    required this.bankAccount,
  });

  @override
  ConsumerState<UpdateUserBankDetailsPage> createState() =>
      _UpdateUserBankDetailsPageState();
}

class _UpdateUserBankDetailsPageState
    extends ConsumerState<UpdateUserBankDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _accountNameCtrl = TextEditingController();
  final TextEditingController _accountNumberCtrl = TextEditingController();
  final TextEditingController _ifscCodeCtrl = TextEditingController();

  FunctionLifetime _functionLifetime = FunctionLifetime.initialize;

  @override
  void initState() {
    // TODO: implement initState
    _accountNumberCtrl.text = widget.bankAccount.accNo ?? '';
    _accountNameCtrl.text = widget.bankAccount.accName ?? '';
    _ifscCodeCtrl.text = widget.bankAccount.ifsc ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// login text
                Align(
                  child: Text(
                    'Bank Details',
                    style: TextStyle(
                      color: text500,
                      fontSize: title,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                /// Account Name
                Text(
                  'Account Name',
                  style: TextStyle(
                    color: text500,
                    fontSize: body2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: text150,
                  ),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    controller: _accountNameCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Name';
                      } else if (value.length < 2) {
                        return 'Name should be greater than 2 characters';
                      } else if (value.length >= 50) {
                        return 'Name shouldn\'t be greater than 50 characters';
                      }
                      return null;
                    },
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: accent2,
                    ),
                    decoration: getInputDecoration('Name'),
                  ),
                ),
                const SizedBox(height: 10),

                /// Account number
                Text(
                  'Account Number',
                  style: TextStyle(
                    color: text500,
                    fontSize: body2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: text150,
                  ),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    controller: _accountNumberCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter account number';
                      } else if (value.length > 18) {
                        return 'Bank Id should not be greater than 18 characters';
                      } else if (value.length < 9) {
                        return 'Bank Id should not be lesser than 9 characters';
                      }

                      bool accountNoValid =
                          RegExp(r'^\d{9,18}$').hasMatch(value);
                      if (accountNoValid == false) {
                        return 'Please enter a valid Account Number';
                      }
                      return null;
                    },
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: accent2,
                    ),
                    decoration: getInputDecoration('0112345678'),
                  ),
                ),
                const SizedBox(height: 10),

                /// ifsc code
                Text(
                  'IFSC Code',
                  style: TextStyle(
                    color: text500,
                    fontSize: body2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: text150,
                  ),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    controller: _ifscCodeCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the IFSC Code';
                      } else if (value.length < 11 || value.length > 11) {
                        return 'IFSC Code must be equal 11 character';
                      }
                      bool ifscValid =
                          RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(value);
                      if (ifscValid == false) {
                        return 'Please enter a valid IFSC Code';
                      }
                      return null;
                    },
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: accent2,
                    ),
                    decoration: getInputDecoration('SBIN0005943'),
                  ),
                ),
                const SizedBox(height: 10),

                // Text(
                //   'Account Number',
                //   style: TextStyle(
                //     color: text500,
                //     fontSize: body2,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                // Container(
                //   margin:
                //       const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     // color: text150,
                //   ),
                //   child: TextFormField(
                //     autovalidateMode: AutovalidateMode.onUserInteraction,
                //     keyboardType: TextInputType.number,
                //     controller: _accountNumberCtrl,
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter account number';
                //       } else if (value.length > 18) {
                //         return 'Bank Id should not be greater than 18 characters';
                //       } else if (value.length < 9) {
                //         return 'Bank Id should not be lesser than 9 characters';
                //       }
                //
                //       bool accountNoValid =
                //           RegExp(r'^\d{9,18}$').hasMatch(value);
                //       if (accountNoValid == false) {
                //         return 'Please enter a valid Account Number';
                //       }
                //       return null;
                //     },
                //     style: TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.w500,
                //       color: accent2,
                //     ),
                //     decoration: getInputDecoration('0112345678'),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Builder(
        builder: (context) {
          if (_functionLifetime == FunctionLifetime.calling) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: accent2),
                  const SizedBox(width: 15),
                  Text(
                    'Updating',
                    style: TextStyle(
                        color: accent2,
                        fontWeight: FontWeight.w500,
                        fontSize: body1),
                  ),
                ],
              ),
            );
          } else {
            /// FunctionLifetime.initialize
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _functionLifetime = FunctionLifetime.calling;
                    });
                    await updateUserBankDetails();
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
                  'Update',
                  style: TextStyle(
                    color: background,
                    fontSize: heading2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> updateUserBankDetails() async {
    try {
      User user = ref.read(userProvider)!;
      // await GoldServices.getUserBanksList(userId: user.id);
      debugPrint(widget.bankAccount.bankId);
      await GoldServices.updateBankAccount(
              bankAccount: BankAccount(
                bankId: widget.bankAccount.bankId,
                userID: user.id,
                accNo: _accountNumberCtrl.text,
                accName: _accountNameCtrl.text,
                ifsc: _ifscCodeCtrl.text,
              ),
              userId: user.id)
          .then((response) async {
        if (response == null) {
          handleError();
          return;
        }

        BankAccount bankAccount = BankAccount(
          userID: user.id,
          accName: response.accountName,
          accNo: response.accountNumber,
          ifsc: response.ifscCode,
          bankId: response.userBankId,
          status: response.status == 'active',
        );
        await DatastoreServices.updateBankAccount(bankAccount: bankAccount)
            .then((value) {
          if (value == null) {
            handleError();
            return;
          }

          // UPDATE IN USER
          ref.read(userProvider.notifier).updateBankAccount(bankAccount: value);
          handleSuccess();
        });
      });
    } catch (e) {
      debugPrint(e.toString());
      handleError();
    }
  }

  void handleError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: error,
        content: Text('Bank Update Failed', style: TextStyle(color: text500)),
      ),
    );
    setState(() {
      _functionLifetime = FunctionLifetime.initialize;
    });
  }

  void handleSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: success,
        content: Text(
          'Bank Updated Successfully',
          style: TextStyle(
            color: text500,
          ),
        ),
      ),
    );
    setState(() {
      _functionLifetime = FunctionLifetime.success;
    });
    Navigator.pop(context);
  }
}
