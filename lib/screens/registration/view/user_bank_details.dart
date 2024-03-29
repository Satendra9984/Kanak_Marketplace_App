import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/providers/user_provider.dart';
import 'package:tasvat/screens/registration/view/user_kyc_page.dart';
import 'package:tasvat/services/datastore_services.dart';
import 'package:tasvat/services/gold_services.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/ui_functions.dart';

class UserBankRegistrationPage extends ConsumerStatefulWidget {
  const UserBankRegistrationPage({super.key});

  @override
  ConsumerState<UserBankRegistrationPage> createState() =>
      _UserBankRegistrationPageState();
}

class _UserBankRegistrationPageState
    extends ConsumerState<UserBankRegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _accountNameCtrl = TextEditingController();
  final TextEditingController _accountNumberCtrl = TextEditingController();
  final TextEditingController _ifscCodeCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();

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
                    keyboardType: TextInputType.text,
                    controller: _ifscCodeCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the IFSC Code';
                      } else if (value.length != 11) {
                        return 'IFSC Code must be equal 11 character';
                      }
                      bool ifscValid =
                          RegExp(r'^[A-Z]{4}[0-9]{7}$').hasMatch(value);
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

                /// ifsc code
                Text(
                  'Address',
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
                    keyboardType: TextInputType.text,
                    controller: _addressCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter adrress of the bank';
                      } else if (value.length < 4) {
                        return 'Invalid Address';
                      }
                      return null;
                    },
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: accent2,
                    ),
                    decoration: getInputDecoration('Kalyani, 741235'),
                  ),
                ),
                const SizedBox(height: 10),
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Bank Details Submit Button
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final user = ref.read(userProvider);
                  safePrint(user);
                  await submitUserBankDetails(user!);
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
                'Submit',
                style: TextStyle(
                  color: background,
                  fontSize: heading2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          /// skip button
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: TextButton(
              onPressed: () {
                // GoldServices.sessionLogIn();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => const UserKYCPage(),
                  ),
                );
              },
              child: Text(
                'Skip for now',
                style: TextStyle(
                  color: accent2,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> submitUserBankDetails(User user) async {
    await GoldServices.createBankAccount(
            accNo: '049152000000975',
            accName: 'Vedant Gupta',
            ifsc: 'YESB0000491',
            userId: user.id)
        .then((value) async {
      await GoldServices.createBankAccount(
        userId: user.id,
        accName: _accountNameCtrl.text,
        accNo: _accountNumberCtrl.text,
        ifsc: _ifscCodeCtrl.text,
      ).then((acc) async {
        if (acc == null) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Something went wrong!')));
          return;
        }
        safePrint(acc);
        await DatastoreServices.addBankAccount(
                account: BankAccount(
                    userID: acc.uniqueId,
                    status: acc.status == "active",
                    bankId: acc.userBankId,
                    accName: acc.accountName,
                    accNo: acc.accountNumber,
                    ifsc: acc.ifscCode))
            .then((val) {
          if (val == null) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Something went wrong!')));
            return;
          }
          ref.read(userProvider.notifier).addBankAccount(account: val);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Successfully Added Bank Account!')));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const UserKYCPage()),
              (route) => false);
        });
      });
    });
  }
}
