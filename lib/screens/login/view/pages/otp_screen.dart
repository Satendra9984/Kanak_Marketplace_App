import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phone, required this.type});
  final String phone;
  final bool type;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpCtrl = TextEditingController();
  Future<void> _verifyOtp(String otp) async {
    safePrint(otp);
    await Amplify.Auth.confirmSignIn(
      confirmationValue: otp
    ).then((result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully Logged In!')));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _otpCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter OTP'
                ),
              ),
              ElevatedButton(onPressed: () async {
                if (widget.type) {
                  await Amplify.Auth.confirmSignUp(
                    username: '+91${widget.phone}',
                    confirmationCode: _otpCtrl.text
                  ).then((value) {
                    if (value.isSignUpComplete) {
                      safePrint('😊😊😊😊😊😊');
                    }
                  });
                } else {
                  await _verifyOtp(_otpCtrl.text);
                }
              }, child: const Text('Verify'))
            ],
          ),
        ),
      ),
    );
  }
}