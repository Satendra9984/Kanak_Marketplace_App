import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/amplifyconfiguration.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/models/auth_model.dart';
import 'package:tasvat/providers/auth_provider.dart';
import 'package:tasvat/screens/home_screen.dart';
import 'package:tasvat/screens/login/view/pages/login_page.dart';

class OnBoardingPage extends ConsumerStatefulWidget {
  const OnBoardingPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends ConsumerState<OnBoardingPage> {
  Future<void> _decideRoute() async {
    await Amplify.Auth.getCurrentUser().then((user) {
      ref.read(authProvider).copyWith(
          phone: user.username,
          id: user.userId,
          authStatus: AuthStatus.loggedin);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    }).catchError((err) {
      safePrint('No user logged in');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LogInPage()));
    });
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      final api = AmplifyAPI(modelProvider: ModelProvider.instance);
      await Amplify.addPlugins([auth, api]);
      await Amplify.configure(amplifyconfig).then((value) async {
        safePrint('😄😄😄 Successfully Coynfigured Amplify!');
        await Amplify.Auth.getCurrentUser().then((value) {
          safePrint('--> ${value.username}, ${value.userId}');
        });
      });
    } on Exception catch (e) {
      safePrint(e);
    }
  }

  void _initialize() async {
    await _configureAmplify().then((value) async {
      await _decideRoute();
    });
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Tasvat',
          style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
