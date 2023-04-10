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

enum PaymentMethod {
  wallet,
  external
}

class BuyBloc extends Bloc<BuyEvent, BuyState> {
  late Razorpay _razorpay;
  late Timer _timer;
  late User _user;

  BuyBloc() : super(const BuyState(status: BuyStatus.initial)) {

    on<ResetEvent>((event, emit) {
      _user = User();
      emit( const BuyState(
        transaction: null,
        rates: null,
        remainingTime: 180,
        status: BuyStatus.initial
      ));
    });
    // starting event for buy confirm screen
    on<RateConfirmEvent>((event, emit) async {
      _razorpayInit();
      _user = event.user;
      emit(state.copyWith(
        remainingTime: 180,
        rates: event.exchangeRates,
        transaction: Transaction(
              blockId: event.exchangeRates.blockId,
              lockPrice: event.exchangeRates.gBuy,
              type: TransactionType.BUY,
              status: TransactionStatus.PENDING,
              quantity: event.quantity,
              amount: _calculateAmountWithTax(
                event.exchangeRates,
                event.quantity
              ),
              userId: event.user.id,
              dateTime: TemporalDateTime.now(),
              transactionReceiverId: '6f6d07c8-9dab-485d-9423-4b16152af571',
              transactionSenderId: event.user.id
        )
      ));
      safePrint(state.transaction);
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (state.remainingTime! > 0) {
          add(TickEvent(seconds: state.remainingTime! - 1));
        } else {
          _timer.cancel();
        }
      });
    });

    on<TickEvent>((event, emit) {
      emit(state.copyWith(remainingTime: event.seconds));
    });                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  

    // when user presses the confirm button
    on<ConfirmButtonPressedEvent>((event, emit) async {
      emit(state.copyWith(
        status: BuyStatus.progress,
        transaction: event.transaction
      ));
      add(ChoosePaymentMethod());
    });

    on<ChoosePaymentMethod>((event, emit) {
      emit(state.copyWith(status: BuyStatus.choose));
    });

    on<PaymentMethodChosen>((event, emit) async {
      emit(state.copyWith(status: BuyStatus.progress));
      await DatastoreServices.addPendingTransaction(
        transaction: state.transaction!
      ).then((tx) async {
        if (event.method == PaymentMethod.external) {
          _checkOutPayment(_user, state.transaction!.amount!);
        } else if (event.method == PaymentMethod.wallet) {
          await DatastoreServices.updateWalletBalance(
            wallet: _user.wallet!,
            balance: _user.wallet!.balance! - state.transaction!.amount!
          ).then((wallet) {
            if (wallet == null) {
              add(PaymentErrorEvent());
              return;
            }
            _user = _user.copyWith(wallet: wallet);
            add(PaymentSuccessEvent(user: _user));
          });
        }
      });
      
    });

    // when payment is successful
    on<PaymentSuccessEvent>((event, emit) async {
      safePrint('|=======================> Successful Payment');
      await DatastoreServices.markSuccessfulPayment(
            transaction: state.transaction!, txId: event.response?.paymentId ?? 'wallet-${state.transaction!.id}')
          .then((tx) async {
        if (tx == null) {
          safePrint('Error Marking txId');
          return;
        }
        emit(state.copyWith(
          transaction: state.transaction!
          .copyWith(txId: event.response?.paymentId ?? 'wallet'))
        );
        await GoldServices.buyGold(
                user: event.user,
                transaction: state.transaction!,
                rates: state.rates!)
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
      safePrint('|=======================> Failed Payment');
      await DatastoreServices.markFailedPayment(
          transaction: state.transaction!).then((value) {
            emit(state.copyWith(status: BuyStatus.failed));
          });
    });

    // when gold purchase is successful
    on<PurchaseSuccessEvent>((event, emit) async {
      safePrint(event.info.goldBalance + event.info.transactionId);
      emit(state.copyWith(
        transaction: state.transaction!.copyWith(
          gpTxId: event.info.transactionId,
          gold_balance: double.parse(event.info.goldBalance)
        )
      ));
      await DatastoreServices.markSuccessfulPurchase(
              transaction: state.transaction!)
          .then((tx) async {
        if (tx == null) {
          safePrint('Cannot mark Transaction Successful');
          await DatastoreServices.markFailedPurchase(transaction: state.transaction!);
          return;
        }
        await DatastoreServices.updateWalletGoldBalance(
                wallet: _user.wallet!, goldBalance: tx.gold_balance!)
            .then((wallet) {
          if (wallet == null) {
            add(WalletUpdateFailedEvent());
            return;
          }
          add(WalletUpdateSuccessEvent(
            wallet: wallet
          ));
        });
      });
    });

    // when gold purchase failed
    on<PurchaseErrorEvent>((event, emit) async {
      await DatastoreServices.markFailedPurchase(
              transaction: state.transaction!)
          .then((value) {
        emit(state.copyWith(status: BuyStatus.failed));
      });
    });

    // when gold adding to wallet is failed
    on<WalletUpdateFailedEvent>((event, emit) async {
      await DatastoreServices.markWalletUpdateFail(
              transaction: state.transaction!)
          .then((value) {
        emit(
          state.copyWith(
            status: BuyStatus.failed,
            transaction: state.transaction?.copyWith(status: TransactionStatus.FAILED)
          )
        );
      });
    });

    // when gold successfully added to wallet
    on<WalletUpdateSuccessEvent>((event, emit) {
      _user = _user.copyWith(wallet: event.wallet);
      emit(state.copyWith(
        status: BuyStatus.success,
        transaction: state.transaction
        ?.copyWith(status: TransactionStatus.SUCCESSFUL)
        )
      );
    });
  }

  double _calculateAmountWithTax(ExchangeRates rates, double quantity) {
    double taxRate = 100;
    for (Tax tax in rates.taxes!) {
      taxRate += double.parse(tax.taxPerc);
    }
    double amount = quantity *
            double.parse(rates.gBuy!) *
            taxRate /
            100;
    return amount;
  }

  _checkOutPayment(User user, double amount) async {
    _razorpay.open({
      'amount': amount.toInt() * 100,
      'description': 'Gold Purchase',
      'name': 'Tasvat Private Ltd.',
      'key': 'rzp_test_nxde3wSg0ubBiN',
      'prefill': {
        'contact': '7029096692',
        'email': 'subhadeepchowdhury41@gmail.com'
      },
      'external': {
        'wallet': ['paytm', 'gpay']
      }
    });
  }

  _razorpayInit() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      add(PaymentSuccessEvent(response: response, user: _user));
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

  get getUser => _user;

  void closeTimer() {
    _timer.cancel();
  }
}
