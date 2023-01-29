import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/amplifyconfiguration.dart';
import 'package:tasvat/screens/login/ui/pages/signup_page.dart';

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
          safePrint('--> $value');
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
      theme: ThemeData.dark(
        useMaterial3: true
      ),
      // home: HomeScreen(),
      home: const SignUpPage(),
    );
  }
}
// https://www.behance.net/gallery/139996351/Goldia-Gold-Trading-Mobile-App