import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasvat/screens/login/bloc/login_bloc.dart';
import 'package:tasvat/screens/login/view/pages/otp_screen.dart';
import 'package:tasvat/screens/signup/view/pages/signup_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
            SnackBar(content: Text('OTP sent to ${state.phone}'
          )));          
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                phone: state.phone,
                type: false,
              )
            )
          );
        } else if (state.status == LoginStatus.invalid) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(content: Text('Form Invalid'
          // )));      
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => OtpScreen(
          //       phone: state.phone,
          //       type: false,
          //     )
          //   )
          // );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: formKey,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    onChanged: (value) {
                      context.read<LoginBloc>().add(
                        PhoneNumberChangedEvent(phone: value)
                      );
                    },
                    validator: (value) {
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(hintText: 'Phone Number'),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      context.read<LoginBloc>().add(
                        PasswordChangedEvent(password: value)
                      );
                    },
                    validator: (value) => null,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(hintText: 'Password'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.read<LoginBloc>().add(
                          LoginButtonPressedEvent()
                        );
                      }, child: const Text('Send OTP')),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const SignUpPage())
                    );
                  }, child: const Text('Sign up'))
                ],
              ))
            ],
          ),
        );
      },
    );
  }
}
