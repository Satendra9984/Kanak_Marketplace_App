import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/models/ModelProvider.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  // initialize a user with only id
  void initializeWithUser(User user) {
    state = user;
  }

  // sync user data
  void syncDetails({required User user}) {
    state = user;
  }

  // update user with details
  void updateUserDetails(
      {String? email,
      String? phone,
      String? fname,
      String? lname,
      String? dob,
      String? kyc,
      String? gpDetails}) {
    state =
        state?.copyWith(email: email, phone: phone, fname: fname, lname: lname);
    if (dob != null) {
      state = state?.copyWith(dob: TemporalDate.fromString(dob));
    }
    safePrint(state.toString());
  }

  void addUserAddress({required Address address}) {
    state = state?.copyWith(address: [...?state?.address, address]);
    safePrint(state.toString());
  }

  void addBankAccount({required BankAccount account}) {
    state = state?.copyWith(bankAccounts: [...?state?.bankAccounts, account]);
  }

  String? getDefaultBankId() {
    return state?.bankAccounts![0].id;
  }

  void updateBankAccount({required BankAccount bankAccount}) {
    List<BankAccount>? bankList = state?.bankAccounts;

    if (bankList != null && bankList.isNotEmpty) {
      int index =
          bankList.indexWhere((element) => element.id == bankAccount.id);
      bankList[index] = bankAccount;
      state = state!.copyWith(bankAccounts: bankList);
    }
  }

  void deleteBankAccount({required BankAccount bankAccount}) {
    List<BankAccount>? bankList = state?.bankAccounts;

    if (bankList != null && bankList.isNotEmpty) {
      bankList.removeWhere((element) => element.id == bankAccount.id);
      state = state!.copyWith(bankAccounts: bankList);
    }
  }

  void updateWalletBalance({required Wallet wallet}) {
    state = state?.copyWith(wallet: wallet);
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, User?>((ref) => UserNotifier());
