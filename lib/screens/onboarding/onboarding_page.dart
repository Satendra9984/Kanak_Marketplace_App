import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/amplifyconfiguration.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/providers/auth_provider.dart';
import 'package:tasvat/providers/inhouse_account_provider.dart';
import 'package:tasvat/providers/token_provider.dart';
import 'package:tasvat/providers/user_provider.dart';
import 'package:tasvat/screens/home_screen.dart';
import 'package:tasvat/screens/login/view/pages/login_page.dart';
import 'package:tasvat/screens/registration/view/user_kyc_page.dart';
import 'package:tasvat/screens/registration/view/user_address.dart';
import 'package:tasvat/screens/registration/view/user_bank_details.dart';
import 'package:tasvat/screens/registration/view/user_details.dart';
import 'package:tasvat/services/datastore_services.dart';
import 'package:tasvat/services/gold_services.dart';
import 'package:tasvat/utils/app_constants.dart';

class OnBoardingPage extends ConsumerStatefulWidget {
  const OnBoardingPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends ConsumerState<OnBoardingPage> {
  Future<void> _decideRoute() async {
    await Amplify.Auth.getCurrentUser().then((user) async {
      // fetch token
      await ref.read(tokenProvider.notifier).init().then((value) async {
        // sets auth provider with user id
        ref.read(authProvider.notifier).logInAndSetUser(
              user.username,
              user.userId,
            );

        // sets user with user id
        ref
            .read(userProvider.notifier)
            .initializeWithUser(User(id: user.userId));

        await DatastoreServices.fetchUserById(user.userId)
            .then((currUser) async {
          if (currUser == null) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserDetailsPage()));
            return;
          }
          ref.read(userProvider.notifier).syncDetails(user: currUser);
          await DatastoreServices.checkRequiredData(uid: user.userId)
              .then((value) async {
            if (value == null) {
                await GoldServices.getUserBankAccounts(userId: user.userId)
                    .then((userAccs) {
                  safePrint(userAccs[0]);
                  ref
                      .read(inhouseAccountProvider.notifier)
                      .setAccount(userAccs[0]);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => true);
                });
            } else if (value == 'Address') {
              await DatastoreServices.fetchUserById(user.userId).then((value) {
                if (value == null) {
                  return;
                }
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const UserAddressRegistrationPage()));
              });
            } else if (value == 'KycDetails') {
              await DatastoreServices.fetchUserById(user.userId).then((value) {
                if (value == null) {
                  return;
                }
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserKYCPage()));
              });
            } else if (value == 'BankAccount') {
              await DatastoreServices.fetchUserById(user.userId).then((value) {
                if (value == null) {
                  return;
                }
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const UserBankRegistrationPage()));
              });
            }
          });
        });
      });
    }).catchError((err) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LogInPage()));
    });
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      final api = AmplifyAPI(modelProvider: ModelProvider.instance);
      // final storage = AmplifyStorageS3();
      await Amplify.addPlugins([auth, api]);
      await Amplify.configure(amplifyconfig).then((value) async {
        safePrint('😄😄😄 Successfully Coynfigured Amplify!');
        // await Amplify.Auth.getCurrentUser().then((value) {
        //   safePrint('XXXXXXXXXXXXXXXXX  $value');

        //   safePrint('--> ${value.username}, ${value.userId}');
        // }).catchError((err) {
        //   safePrint('XXXXXXXXXXXXXXXXX  $err');

        // });
      });
    } on AmplifyAlreadyConfiguredException catch (e) {
      safePrint(e);
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
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Text(
          'Tasvat',
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: accent2,
          ),
        ),
      ),
    );
  }
}
