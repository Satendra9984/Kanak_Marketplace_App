import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasvat/models/gold_models/rate_model.dart';

part 'buy_event.dart';
part 'buy_state.dart';

class BuyBloc extends Bloc<BuyEvent, BuyState> {
  BuyBloc() : super(BuyInitial()) {
    on<RateConfirmEvent>((event, emit) {
      onRateConfirmEventHandler();
    });

    on<ConfirmButtonPressedEvent>((event, emit) {
      onConfirmButtonPressedEventHandler();
    });
    on<PaymentSuccessEvent>((event, emit) {
      onPaymentSuccessEventHandler();
    });
    on<PaymentErrorEvent>((event, emit) {
      onPaymentErrorEventHandler();
    });
    on<BuySuccessEvent>((event, emit) {
      onBuySuccessEventHandler();
    });
    on<BuyErrorEvent>((event, emit) {
      onBuyErrorEventHandler();
    });
    on<WalletUpdateFailedEvent>((event, emit) {
      onWalletUpdateErrorEventHandler();
    });
    on<WalletUpdateSuccessEvent>((event, emit) {
      onWalletUpdateErrorEventHandler();
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
