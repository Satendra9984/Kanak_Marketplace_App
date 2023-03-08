import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/screens/login/bloc/login_bloc.dart';
import 'package:tasvat/screens/onboarding/onboarding_page.dart';
import 'package:tasvat/screens/registration/view/aadhar_pan.dart';
import 'package:tasvat/screens/registration/view/add_user_details.dart';
import 'package:tasvat/screens/registration/view/user_bank_details.dart';
import 'package:tasvat/screens/signup/bloc/sign_up_bloc.dart';
import 'package:tasvat/services/auth_services.dart';

void main() {
  runApp(
    ProviderScope(
      child: RepositoryProvider(
        create: (context) => AuthRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginBloc(
                authRepository: context.read<AuthRepository>(),
              ),
            ),
            BlocProvider(create: (context) => SignUpBloc()),
          ],
          child: const Tasvat(),
        ),
      ),
    ),
  );
}

class Tasvat extends ConsumerStatefulWidget {
  const Tasvat({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TasvatState();
}

class _TasvatState extends ConsumerState<Tasvat> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthRepository(),
        ),
      ],
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
        child: const MaterialApp(
          // home: OnBoardingPage(),
          // home: UserBankDetailsPage(),
          home: UserAddressPage(),
          // home: UserKYCPage(),
        ),
      ),
    );
  }
}
