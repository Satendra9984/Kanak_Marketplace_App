import 'dart:async';
import 'package:amplify_core/amplify_core.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/models/gold_models/buy_info_model.dart';
import 'package:tasvat/models/gold_models/rate_model.dart';
part 'buy_event.dart';
part 'buy_state.dart';

class BuyBloc extends Bloc<BuyEvent, BuyState> {
  late CustomTimerController timerController;
  late Timer timer;
  late Transaction _transaction;
  BuyBloc() : super(BuyInitial()) {
    on<RateConfirmEvent>((event, emit) {
      _transaction = Transaction(
        blockId: event.exchangeRates.blockId,
        lockPrice: event.exchangeRates.gBuy,
        type: TransactionType.BUY,
        quantity: event.quantity,
        dateTime: TemporalDateTime.now(),
        transactionReceiverId: '6f6d07c8-9dab-485d-9423-4b16152af571',
        transactionSenderId: event.userId,
      );
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
    on<PurchaseSuccessEvent>((event, emit) {
      onBuySuccessEventHandler();
    });
    on<PurchaseErrorEvent>((event, emit) {
      onBuyErrorEventHandler();
    });
    on<WalletUpdateFailedEvent>((event, emit) {
      onWalletUpdateErrorEventHandler();
    });
    on<WalletUpdateSuccessEvent>((event, emit) {
      onWalletUpdateErrorEventHandler();
    });
  }

  Future<void> onRateConfirmEventHandler() async {
    // TODO: TRANSFER TO BUY-CONFIRM SCREEN (RATE_DATA, AMOUNT OR QUANTITY)
    // TODO: START TIMER

    timer = Timer.periodic(
      const Duration(seconds: 180),
      (timer) {
        if (timer.isActive) {
        } else if (timer.isActive == false) {
          // TODO: EMIT CANCEL ALL STATES
          debugPrint(timer.tick.toString());
        }
      },
    );

    timerController.start();
  }

  Future<void> onConfirmButtonPressedEventHandler() async {
    // TODO: CALL PAYMENTS
  }
  Future<void> onPaymentErrorEventHandler() async {}
  Future<void> onPaymentSuccessEventHandler() async {
    // TODO: CALL AUGMONT BUY-API
    // TODO: UPDATE IN TASVAT'S DATABASE
    // TODO: CALL BUY-SUCCESS OR BUY-FAILURE EVENTS
  }
  Future<void> onBuyErrorEventHandler() async {}
  Future<void> onBuySuccessEventHandler() async {}
  Future<void> onWalletUpdateErrorEventHandler() async {}
  Future<void> onWalletUpdateSuccessEventHandler() async {}

  addTimerController(CustomTimerController ctrl) async {
    timerController = ctrl;
  }
}
