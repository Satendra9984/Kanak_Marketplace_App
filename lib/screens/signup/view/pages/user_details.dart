import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/screens/login/view/pages/login_page.dart';
import 'package:tasvat/screens/login/view/pages/otp_screen.dart';

import '../../../../utils/app_constants.dart';
import '../../../../utils/ui_functions.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // bool _showPassword = false;
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _pinCodeCtrl = TextEditingController();

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
                    'Register',
                    style: TextStyle(
                      color: text500,
                      fontSize: title,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// lets started
                Text(
                  'Let\'s get Started',
                  style: TextStyle(
                    color: text500,
                    fontSize: heading1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Create an account',
                  style: TextStyle(
                    color: text300,
                    fontSize: body1,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// LOGIN BUTTON
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
                'Login',
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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LogInPage()));
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
