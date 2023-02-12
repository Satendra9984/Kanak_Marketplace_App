import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/models/auth_model.dart';

class AuthNotifier extends StateNotifier<AuthUserModel> {
  AuthNotifier(): super(const AuthUserModel(
    email: '', phone: '', id: '',
    authStatus: AuthStatus.loggedout
  ));

  void logInAndSetUser(String username, String userId) {
    state.copyWith(phone: username, id: userId, authStatus: AuthStatus.loggedin);
  }

  void logOutAndClearUser() {
    state.copyWith(phone: '', email: '', id: '', authStatus: AuthStatus.loggedout);
  }

}

final authProvider = StateNotifierProvider<AuthNotifier,
  AuthUserModel>((ref) => AuthNotifier());