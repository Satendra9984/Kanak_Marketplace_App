import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

abstract class AuthServices {
  Future<SignUpResult> signUpWithPhoneAndPassword({
    required String phone,
    required String email,
    required String password
  });
  Future<SignInResult> signInWithPhoneAndPassword({
    required String phone,
    required String password
  });
  Future<SignInResult> confirmSignIn(String code);
  Future<void> resendConfirmation(String phone);
}

class AuthRepository implements AuthServices {
  @override
  Future<SignUpResult> signUpWithPhoneAndPassword({
    required String phone,
    required String email,
    required String password
  }) async {
    return await Amplify.Auth.signUp(
      username: '+91$phone',
      password: password,
      options: CognitoSignUpOptions(
        userAttributes: {
          CognitoUserAttributeKey.email: email
        }
      )
    );
  }
  @override
  Future<SignInResult> signInWithPhoneAndPassword({
    required String phone,
    required String password
  }) async {
    return await Amplify.Auth.signIn(username: '+91$phone', password: password).then((value) {
      safePrint(value.isSignedIn);
      return value;
    });
  }
  Future<SignUpResult> confirmSignUp(String phone, String code) async {
    return await Amplify.Auth.confirmSignUp(username: '+91$phone', confirmationCode: code);
  }
  @override
  Future<SignInResult> confirmSignIn(String code) async {
    return await Amplify.Auth.confirmSignIn(confirmationValue: code);
  }
  @override
  Future<void> resendConfirmation(String phone) async {
    await Amplify.Auth.resendSignUpCode(username: '+91$phone');
  }
  Future<void> signOut() async {
    await Amplify.Auth.signOut();
  }
}