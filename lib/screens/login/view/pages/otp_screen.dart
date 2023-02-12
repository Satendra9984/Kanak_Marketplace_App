import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/screens/home_screen.dart';
import 'package:tasvat/screens/login/view/pages/login_page.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/ui_functions.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phone, required this.type});
  final String phone;
  final bool type;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _otpCtrl = TextEditingController();
  Future<void> _verifyOtp(String otp) async {
    if (_formKey.currentState!.validate()) {
      await Amplify.Auth.confirmSignIn(confirmationValue: otp).then((result) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully Logged In!')),
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx) => const HomeScreen()),
          (route) => true
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: background,
        title: Text(
          'Verification',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: text500),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Enter Your Verification Code',
                  style: TextStyle(
                    color: text500,
                    fontSize: title + 5,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 25),

                /// enter OTP
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _otpCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter OTP';
                      } else if (int.tryParse(value) is int == false) {
                        return 'Please Enter a valid OTP number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: accent2,
                    ),
                    decoration: getInputDecoration('Enter OTP'),
                  ),
                ),
                const SizedBox(height: 15),

                /// verify
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (widget.type) {
                          await Amplify.Auth.confirmSignUp(
                                  username: '+91${widget.phone}',
                                  confirmationCode: _otpCtrl.text)
                              .then((value) {
                            if (value.isSignUpComplete) {
                              safePrint('😊😊😊😊😊😊');
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const LogInPage()
                                ),
                                (route) => false
                              );
                            }
                          });
                        } else {
                          await _verifyOtp(_otpCtrl.text);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 50.0),
                      maximumSize: const Size(double.infinity, 60.0),
                      backgroundColor: accent1,
                    ),
                    child: Text(
                      'Verify',
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
    );
  }
}
