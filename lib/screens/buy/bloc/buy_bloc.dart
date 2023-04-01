import 'dart:async';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/models/gold_models/buy_info_model.dart';
import 'package:tasvat/models/gold_models/rate_model.dart';
import 'package:tasvat/services/datastore_services.dart';
import 'package:tasvat/services/gold_services.dart';

part 'buy_event.dart';
part 'buy_state.dart';

class BuyBloc extends Bloc<BuyEvent, BuyState> {
  late Transaction _transaction;
  late User _user;
  late ExchangeRates _rates;
  late Razorpay _razorpay;
  late Timer _timer;
  int _timeRemaining = 270;

  BuyBloc() : super(BuyInitial()) {
    // starting event for buy confirm screen
    on<RateConfirmEvent>((event, emit) async {
      _rates = event.exchangeRates;
      _user = event.user;
      // _timer = Timer.periodic(
      //   const Duration(seconds: 1), (timer) {
      //     if (_timeRemaining > 0) {
      //       _timeRemaining--;
      //       print(_timeRemaining);
      //     } else {
      //       _timer.cancel();
      //     }
      //   });
      _transaction = Transaction(
          blockId: event.exchangeRates.blockId,
          lockPrice: event.exchangeRates.gBuy,
          type: TransactionType.BUY,
          status: TransactionStatus.PENDING,
          quantity: event.quantity,
          dateTime: TemporalDateTime.now(),
          transactionReceiverId: '6f6d07c8-9dab-485d-9423-4b16152af571',
          transactionSenderId: event.user.id);

      _razorpayInit();
    });

    // when user presses the confirm button
    on<ConfirmButtonPressedEvent>((event, emit) async {
      await DatastoreServices.addPendingTransaction(transaction: _transaction)
          .then((tx) {
        _checkOutPayment(_user, calculateAmountWithTax());
        emit(BuyProccessing(progress: 0));
      });
    });

    // when payment is successful
    on<PaymentSuccessEvent>((event, emit) async {
      await DatastoreServices.markSuccessfulPayment(
              transaction: _transaction, txId: event.response.paymentId!)
          .then((tx) async {
        if (tx == null) {
          safePrint('Error Marking txId');
          return;
        }
        _transaction = tx;
        await GoldServices.buyGold(
                user: _user, transaction: _transaction, rates: _rates)
            .then((info) {
          if (info == null) {
            add(PurchaseErrorEvent());
            return;
          }
          add(PurchaseSuccessEvent(info: info));
        });
      });
    });

    // when gold purchase fails
    on<PaymentErrorEvent>((event, emit) async {
      await DatastoreServices.markFailedPayment(transaction: _transaction);
    });

    // when gold purchase is successful
    on<PurchaseSuccessEvent>((event, emit) async {
      _transaction = _transaction.copyWith(
          gpTxId: event.info.transactionId,
          balance: double.parse(event.info.goldBalance));
      await DatastoreServices.markSuccessfulPurchase(transaction: _transaction)
          .then((tx) async {
        if (tx == null) {
          safePrint('Cannot mark Transaction Successful');
          return;
        }
        await DatastoreServices.updateWalletGoldBalance(
                id: _user.userWalletId!, balance: tx.balance!)
            .then((wallet) {
          if (wallet == null) {
            add(WalletUpdateFailedEvent());
            return;
          }
          add(WalletUpdateSuccessEvent());
        });
      });
    });

    // when gold purchase failed
    on<PurchaseErrorEvent>((event, emit) async {
      await DatastoreServices.markFailedPurchase(transaction: _transaction)
          .then((value) {
        emit(BuyErrorState(type: FailType.PURCHASEFAIL));
      });
    });

    // when gold adding to wallet is failed
    on<WalletUpdateFailedEvent>((event, emit) async {
      await DatastoreServices.markWalletUpdateFail(transaction: _transaction)
          .then((value) {
        emit(BuyErrorState(type: FailType.WALLETUPDATEFAIL));
      });
    });

    // when gold successfully added to wallet
    on<WalletUpdateSuccessEvent>((event, emit) {
      emit(BuyCompletedState());
    });
  }

  double calculateAmountWithTax() {
    double taxRate = 100;
    for (Tax tax in _rates.taxes!) {
      taxRate += double.parse(tax.taxPerc);
    }
    return _transaction.quantity! * double.parse(_rates.gBuy!) * taxRate / 100;
  }

  _checkOutPayment(User user, double amount) async {
    _razorpay.open({
      'amount': amount,
      'description': 'Gold Purchase',
      'name': 'Tasvat Private Ltd.',
      'key': 'rzp_test_nxde3wSg0ubBiN',
      'prefill': {'contact': user.phone, 'email': user.email},
      'external': {
        'wallet': ['paytm']
      }
    });
  }

  _razorpayInit() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      add(PaymentSuccessEvent(response: response));
    });
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      add(PaymentErrorEvent(response: response));
    });
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
        (ExternalWalletResponse response) {
      safePrint(response.walletName);
    });
  }

  ExchangeRates get getRates => _rates;
  int get remainingTime => _timeRemaining;
  Transaction get getTransaction => _transaction;

  @override
  Future<void> close() async {
    super.close();
    // _timer.cancel();
  }
}
