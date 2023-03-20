import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasvat/models/gold_models/rate_model.dart';

part 'buy_event.dart';
part 'buy_state.dart';

class BuyBloc extends Bloc<BuyEvent, BuyState> {
  BuyBloc() : super(BuyInitial()) {
    on<BuyEvent>((event, emit) {
      // implement event handler
      if (event is RateConfirmEvent) {
        onRateConfirmEventHandler();
      } else if (event is ConfirmButtonPressedEvent) {
        onConfirmButtonPressedEventHandler();
      } else if (event is PaymentErrorEvent) {
        onPaymentErrorEventHandler();
      } else if (event is PaymentSuccessEvent) {
        onPaymentSuccessEventHandler();
      } else if (event is BuyErrorEvent) {
        onBuyErrorEventHandler();
      } else if (event is BuySuccessEvent) {
        onBuySuccessEventHandler();
      } else if (event is WalletUpdateFailedEvent) {
        onWalletUpdateErrorEventHandler();
      } else if (event is WalletUpdateSuccessEvent) {
        onWalletUpdateSuccessEventHandler();
      }
    });
  }

  Future<void> onRateConfirmEventHandler() async {}
  Future<void> onConfirmButtonPressedEventHandler() async {}
  Future<void> onPaymentErrorEventHandler() async {}
  Future<void> onPaymentSuccessEventHandler() async {}
  Future<void> onBuyErrorEventHandler() async {}
  Future<void> onBuySuccessEventHandler() async {}
  Future<void> onWalletUpdateErrorEventHandler() async {}
  Future<void> onWalletUpdateSuccessEventHandler() async {}
}
