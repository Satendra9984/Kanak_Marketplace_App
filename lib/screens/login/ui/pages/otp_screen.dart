import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phone, required this.email});
  final String phone;
  final String email;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpCtrl = TextEditingController();
  Future<void> _verifyOtp(String otp) async {
    await Amplify.Auth.confirmSignUp(
      username: '+91${widget.phone}',
      confirmationCode: otp,
    ).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully Logged In')));
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
                await _verifyOtp(_otpCtrl.text);
              }, child: const Text('Verify'))
            ],
          ),
        ),
      ),
    );
  }
}