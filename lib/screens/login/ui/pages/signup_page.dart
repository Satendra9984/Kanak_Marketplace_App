import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tasvat/screens/login/ui/pages/otp_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  Future<void> _signUp(String phone, String email, String password) async {
    await Amplify.Auth.signUp(username: '+91$phone', password: password,
      options: CognitoSignUpOptions(
        userAttributes: {
          CognitoUserAttributeKey.email: email
        }
      )
    ).then((result) {
      if (result.isSignUpComplete) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => OtpScreen(phone: _phoneCtrl.text, email: _emailCtrl.text)));
      }
      safePrint(result);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneCtrl,
                  decoration: const InputDecoration(
                    hintText: 'Phone Number',
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailCtrl,
                  decoration: const InputDecoration(
                    hintText: 'Email'
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: _passwordCtrl,
                  decoration: const InputDecoration(
                    hintText: 'Password'
                  ),
                ),
                ElevatedButton(onPressed: () async {
                  await _signUp(_phoneCtrl.text, _emailCtrl.text, _passwordCtrl.text);
                }, child: const Text('Send OTP')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}