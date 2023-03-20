import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/amplifyconfiguration.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/models/auth_model.dart';
import 'package:tasvat/providers/auth_provider.dart';
import 'package:tasvat/providers/user_provider.dart';
import 'package:tasvat/screens/home_screen.dart';
import 'package:tasvat/screens/login/view/pages/login_page.dart';
import 'package:tasvat/screens/registration/view/user_kyc_page.dart';
import 'package:tasvat/screens/registration/view/user_address.dart';
import 'package:tasvat/screens/registration/view/user_bank_details.dart';
import 'package:tasvat/screens/registration/view/user_details.dart';
import 'package:tasvat/services/auth_services.dart';
import 'package:tasvat/services/datastore_services.dart';
import 'package:tasvat/services/local_db_services.dart';
import 'package:tasvat/utils/app_constants.dart';

class OnBoardingPage extends ConsumerStatefulWidget {
  const OnBoardingPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends ConsumerState<OnBoardingPage> {
  Future<void> _decideRoute() async {
    await Amplify.Auth.getCurrentUser().then((user) async {
      final expiry = await LocalDBServices.getGPTokenExpiry();

      if (expiry == null ||
          DateTime.now().compareTo(DateTime.parse(expiry)) > 0) {
        safePrint('Token Expired');
        AuthRepository().signOut().then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LogInPage()));
        });

        return;
      }
      // sets auth provider with user id
      ref.read(authProvider.notifier).logInAndSetUser(
            user.username,
            user.userId,
          );

      // sets user with user id
      ref.read(userProvider.notifier).initializeWithUser(User(id: user.userId));

      await DatastoreServices.fetchUserById(user.userId);

      await DatastoreServices.checkRequiredData(user.userId)
          .then((value) async {
        if (value == null) {
          await DatastoreServices.fetchUserById(user.userId).then((value) {
            if (value == null) {
              return;
            }
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          });
        } else if (value == 'UserDetails') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const UserDetailsPage()));
        } else if (value == 'Address') {
          await DatastoreServices.fetchUserById(user.userId).then((value) {
            if (value == null) {
              return;
            }
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserAddressPage()));
          });
        } else if (value == 'KycDetails') {
          await DatastoreServices.fetchUserById(user.userId).then((value) {
            if (value == null) {
              return;
            }
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const UserKYCPage()));
          });
        } else if (value == 'BankAccount') {
          await DatastoreServices.fetchUserById(user.userId).then((value) {
            if (value == null) {
              return;
            }
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserBankDetailsPage()));
          });
        }
      });
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
      final storage = AmplifyStorageS3();
      await Amplify.addPlugins([auth, api, storage]);
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
