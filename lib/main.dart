import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/providers/token_provider.dart';
import 'package:tasvat/screens/add_money/bloc/add_money_bloc.dart';
import 'package:tasvat/screens/buy/bloc/buy_bloc.dart';
import 'package:tasvat/screens/login/bloc/login_bloc.dart';
import 'package:tasvat/screens/onboarding/onboarding_page.dart';
import 'package:tasvat/screens/sell/bloc/sell_bloc.dart';
import 'package:tasvat/screens/signup/bloc/sign_up_bloc.dart';
import 'package:tasvat/screens/withdraw_money/bloc/withdraw_money_bloc.dart';
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
                    )),
            BlocProvider(create: (context) => SignUpBloc()),
            BlocProvider(create: (context) => BuyBloc()),
            BlocProvider(create: (context) => SellBloc()),
            BlocProvider(create: (context) => AddMoneyBloc()),
            BlocProvider(create: (context) => WithdrawMoneyBloc()),
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
  void dispose() {
    ref.read(tokenProvider.notifier).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const OnBoardingPage(),
      // home: HomeScreen(),
      // home: UserBankDetailsPage(),
      // home: UserAddressPage(),
      // home: UserKYCPage(),
    );
  }
}
