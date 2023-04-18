import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/models/gold_models/bank_response.dart';

class InhouseAccountNotifier extends StateNotifier<UserBank?> {
  InhouseAccountNotifier() : super(null);

  void setAccount(UserBank account) {
    state = account;
  }
}

final inhouseAccountProvider =
    StateNotifierProvider<InhouseAccountNotifier, UserBank?>(
      (ref) => InhouseAccountNotifier()
);
