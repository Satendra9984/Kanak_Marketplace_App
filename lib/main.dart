import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/amplifyconfiguration.dart';
import 'package:tasvat/screens/login/bloc/login_bloc.dart';
import 'package:tasvat/screens/login/view/pages/login_page.dart';
import 'package:tasvat/screens/onboarding/onboarding_page.dart';
import 'package:tasvat/screens/signup/bloc/sign_up_bloc.dart';
import 'package:tasvat/services/auth_services.dart';
import 'package:tasvat/widgets/gold_rate_graph.dart';

void main() {
  runApp(const ProviderScope(
    child: Tasvat()
  ));
}

class Tasvat extends ConsumerStatefulWidget {
  const Tasvat({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TasvatState();
}

<<<<<<< HEAD
class _TasvatState extends State<Tasvat> {
  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugins([auth]);
      await Amplify.configure(amplifyconfig).then((value) async {
        safePrint('😄😄😄 Successfully Coynfigured Amplify!');
        await Amplify.Auth.getCurrentUser().then((value) {
          safePrint('--> ${value.username}, ${value.userId}');
        });
      });
      // tasvat52@gmail.com
      // tasvat@123
    } on Exception catch (e) {
      safePrint(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

=======
class _TasvatState extends ConsumerState<Tasvat> {
>>>>>>> 433fba7b8715d58e2b5c4aa54efe09499367271d
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
<<<<<<< HEAD
          // child: LogInPage(),
          child: const HomeScreen(),
          // child: GoldRateGraph(),
=======
          child: const OnBoardingPage(),
          // child: const HomeScreen(),
>>>>>>> 433fba7b8715d58e2b5c4aa54efe09499367271d
        ),
      ),
    );
  }
}