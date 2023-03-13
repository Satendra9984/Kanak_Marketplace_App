import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/models/ModelProvider.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);
  void initializeWithUser(User user) {
    state = user;
  }
  void syncDetails({
    required User user
  }) {
    state = user;
    safePrint(user.toString());
  }
  void updateUserDetails({
    String? email,
    String? phone,
    String? fname,
    String? lname,
    String? dob
  }) {
    state = state?.copyWith(
      email: email,
      phone: phone,
      fname: fname,
      lname: lname
    );
    if (dob != null) {
      state = state?.copyWith(dob: TemporalDate.fromString(dob));
    }
    safePrint(state.toString());
  }
  void addUserAddress({
    required Address address
  }) {
    state = state?.copyWith(
      address: [...?state?.address, address]
    );
    safePrint(state.toString());
  }
  void addBankAccount({
    required BankAccount account
  }) {
    state = state?.copyWith(
      bankAccounts: [...?state?.bankAccounts, account]
    );
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User?>(
  (ref) => UserNotifier()
);