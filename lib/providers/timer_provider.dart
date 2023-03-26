import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class BuyTimer extends StateNotifier<Timer> {
  BuyTimer()
      : super(
          Timer.periodic(const Duration(seconds: 0), (timer) {}),
        );

  void startTimer() {
    state = Timer.periodic(const Duration(seconds: 180), (timer) {});
  }

  Timer getCurrentTimerState() {
    return state;
  }

  void cancelTimer() {
    state.cancel();
  }
}

final timerProvider =
  StateNotifierProvider<BuyTimer, Timer>((ref) => BuyTimer()
);
