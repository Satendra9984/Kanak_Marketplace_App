import 'package:flutter/material.dart';
import 'package:tasvat/models/function_lifetime_enum.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/ui_functions.dart';

class AddUserBankDetailsPage extends StatefulWidget {
  const AddUserBankDetailsPage({super.key});

  @override
  State<AddUserBankDetailsPage> createState() => _AddUserBankDetailsPageState();
}

class _AddUserBankDetailsPageState extends State<AddUserBankDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _accountNameCtrl = TextEditingController();
  final TextEditingController _accountNumberCtrl = TextEditingController();
  final TextEditingController _ifscCodeCtrl = TextEditingController();
  FunctionLifetime _functionLifetime = FunctionLifetime.initialize;

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
                      } else if (value.length < 11 || value.length < 11) {
                        return 'IFSC Code must be equal 11 character';
                      }
                      bool ifscValid =
                          RegExp(r'^[A-Za-z]{4}[0-9]{6,7}$').hasMatch(value);
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
                    'Adding Bank Account',
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
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _functionLifetime = FunctionLifetime.calling;
                    });
                    await addUserBankDetails();
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
                  'Add Bank Account',
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

  Future<void> addUserBankDetails() async {
    // TODO: SUBMIT USER ADDRESS DETAILS
    try {
      // await GoldServices.
      Future.delayed(const Duration(seconds: 5)).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: success,
            content: Text('Bank Added Successfully',
                style: TextStyle(
                  color: text500,
                )),
          ),
        );
        setState(() {
          _functionLifetime = FunctionLifetime.success;
        });
        // Navigator.pop(context);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: error,
          content: Text('Bank Add Failed', style: TextStyle(color: text500)),
        ),
      );
      setState(() {
        _functionLifetime = FunctionLifetime.initialize;
      });
    }
  }
}
