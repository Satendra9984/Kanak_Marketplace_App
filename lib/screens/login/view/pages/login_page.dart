import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasvat/screens/login/bloc/login_bloc.dart';
import 'package:tasvat/screens/login/view/pages/otp_screen.dart';
import 'package:tasvat/screens/signup/view/pages/signup_page.dart';
import 'package:tasvat/utils/ui_functions.dart';
import '../../../../utils/app_constants.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  @override
  void initState() {
    context.read<LoginBloc>().addFormKey(formKey);
    context.read<LoginBloc>().add(LoginRestartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        safePrint(state.status);
        if (state.status == LoginStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('OTP sent to ${state.phone}')));
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OtpScreen(
              phone: state.phone,
              type: false,
          )));
        } else if (state.status == LoginStatus.invalid) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Form Invalid'
          )));
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                phone: state.phone,
                type: false,
              )
            )
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: background,
          body: Form(
            key: formKey,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// login text
                  Align(
                    child: Text(
                      'Welcome Back!',
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
                      fontSize: body2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 25),
                  Text(
                    'Phone Number',
                    style: TextStyle(
                      color: text500,
                      fontSize: body2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    // height: 60,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        context
                            .read<LoginBloc>()
                            .add(PhoneNumberChangedEvent(phone: value));
                      },
                      validator: (value) {
                        String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                        RegExp regExp = RegExp(pattern);
                        if (value == null || value.isEmpty) {
                          return 'Please enter mobile number';
                        } else if (!regExp.hasMatch(value)) {
                          return 'Please enter valid mobile number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: accent2,
                      ),
                      decoration: getInputDecoration('Phone Number'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Password',
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
                      onChanged: (value) {
                        context
                            .read<LoginBloc>()
                            .add(PasswordChangedEvent(password: value));
                      },
                      validator: (value) => null,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: accent2,
                      ),
                      obscureText: _showPassword,
                      decoration: getInputDecoration('Password').copyWith(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          child: Icon(
                            !_showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: accent2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// LOGIN BUTTON
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<LoginBloc>().add(LoginButtonPressedEvent());
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Dont\'t have an account? ',
                    style: TextStyle(
                      color: text400,
                      fontSize: body2,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
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
      },
    );
  }
}