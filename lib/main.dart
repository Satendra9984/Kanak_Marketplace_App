import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasvat/amplifyconfiguration.dart';
import 'package:tasvat/screens/home_screen.dart';
import 'package:tasvat/screens/login/bloc/login_bloc.dart';
import 'package:tasvat/screens/login/view/pages/login_page.dart';
import 'package:tasvat/screens/login/view/pages/otp_screen.dart';
import 'package:tasvat/screens/signup/bloc/sign_up_bloc.dart';
import 'package:tasvat/services/auth_services.dart';

void main() {
  runApp(const Tasvat());
}

class Tasvat extends StatefulWidget {
  const Tasvat({super.key});

  @override
  State<Tasvat> createState() => _TasvatState();
}

class _TasvatState extends State<Tasvat> {
  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugins([auth]);
      await Amplify.configure(amplifyconfig).then((value) async {
        safePrint('😄😄😄 Successfully Configured Amplify!');
        await Amplify.Auth.getCurrentUser().then((value) {
          safePrint('--> ${value.username}, ${value.userId}');
        });
      });
    } on Exception catch (e) {
      safePrint(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: RepositoryProvider(
        create: (_) => AuthRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  LoginBloc(authRepository: context.read<AuthRepository>()),
            ),
            BlocProvider(
              create: (context) => SignUpBloc(),
            ),
          ],
          // child: LogInPage(),
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
// @[https://www.behance.net/gallery/139996351/Goldia-Gold-Trading-Mobile-App]
