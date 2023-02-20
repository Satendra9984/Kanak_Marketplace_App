import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/screens/login/view/pages/login_page.dart';
import 'package:tasvat/screens/login/view/pages/otp_screen.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/ui_functions.dart';

class KYCPage extends StatefulWidget {
  const KYCPage({super.key});

  @override
  State<KYCPage> createState() => _KYCPageState();
}

class _KYCPageState extends State<KYCPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  final TextEditingController _aadharCtrl = TextEditingController();
  final TextEditingController _panCtrl = TextEditingController();

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// KYC text
                Align(
                  child: Text(
                    'KYC Details',
                    style: TextStyle(
                      color: text500,
                      fontSize: title,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// Aadhar number
                Text(
                  'Aadhar',
                  style: TextStyle(
                    color: text500,
                    fontSize: body2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: text150,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _aadharCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Aadhar number';
                      }
                      bool aadharValid =
                          RegExp(r'^[2-9]{1}[0-9]{3}[0-9]{4}[0-9]{4}$')
                              .hasMatch(value);

                      if (!aadharValid) {
                        return 'Please enter valid Aadhar number';
                      }
                      return null;
                    },
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: accent2,
                    ),
                    decoration: getInputDecoration('123412341234'),
                  ),
                ),

                const SizedBox(height: 10),

                /// Pan Number
                Text(
                  'Pan',
                  style: TextStyle(
                    color: text500,
                    fontSize: body2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: text150,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _panCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Pan Number';
                      } else {
                        bool emailValid =
                            RegExp(r"[A-Z]{5}[0-9]{4}[A-Z]{1}").hasMatch(value);
                        if (!emailValid) {
                          return 'Please Enter a valid Pan number';
                        }
                      }

                      return null;
                    },
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: accent2,
                    ),
                    decoration: getInputDecoration('ABCTY1234D'),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Confirm BUTTON
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ElevatedButton(
              onPressed: () async {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                minimumSize: const Size(double.infinity, 50.0),
                maximumSize: const Size(double.infinity, 60.0),
                backgroundColor: accent1,
              ),
              child: Text(
                'Complete KYC',
                style: TextStyle(
                  color: background,
                  fontSize: heading2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          /// Already account SignUp button
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LogInPage(),
                ),
              );
            },
            child: RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(
                  color: text400,
                  fontSize: body2,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: 'Login',
                    style: TextStyle(
                      color: accent2,
                      fontSize: body1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
