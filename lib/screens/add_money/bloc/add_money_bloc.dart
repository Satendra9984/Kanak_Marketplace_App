import 'package:amplify_core/amplify_core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../models/Transaction.dart';
import '../../../models/TransactionStatus.dart';
import '../../../models/TransactionType.dart';
import '../../../models/User.dart';
import '../../../models/Wallet.dart';
import '../../../services/datastore_services.dart';
import '../../../utils/loggs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_money_event.dart';
part 'add_money_state.dart';

class AddMoneyBloc extends Bloc<AddMoneyEvent, AddMoneyState> {
  late Razorpay _razorpay;
  late User _user;
  Transaction? transaction;

  AddMoneyBloc() : super(AddMoneyInitialState()) {
    on<AddMoneyInitial>((event, emit) {
      /// Initialize The User
      _user = event.user;
      _razorpayInit();
    });

    on<AddButtonPressedEvent>((event, emit) async {
      transaction = Transaction(
        status: TransactionStatus.PENDING,
        type: TransactionType.ADD,
        userId: _user.id,
        amount: event.amount,
        dateTime: TemporalDateTime.now(),
      );
      logWithColor(
          message: 'transaction: ${transaction?.toString()}', color: 'blue');

      await DatastoreServices.addPendingTransaction(
        transaction: transaction!,
      ).then((value) {
        /// emitting AddMoneyProcessingState
        emit(AddMoneyProcessing(transaction: transaction!));
        _checkOutPayment(_user, event.amount);
      });
    });

    on<AddMoneySuccessEvent>((event, emit) async {
      logWithColor(
          message: '|=======================> Successful Payment',
          color: 'green');
      // Marking successful payment in database
      debugPrint(transaction?.toMap().toString());
      await DatastoreServices.markSuccessfulPayment(
              transaction: transaction!,
              txId: event.response?.paymentId ??
                  'wallet-${event.response?.paymentId}')
          .then((tx) async {
        if (tx == null) {
          logWithColor(message: 'Error Marking txId', color: 'red');
          return;
        }
        transaction = tx;
        await DatastoreServices.updateWalletBalance(
          wallet: _user.wallet!,
          balance: transaction!.balance!,
        ).then((wallet) {
          if (wallet == null) {
            add(WalletUpdateFailedEvent());
          } else {
            add(WalletUpdateSuccessEvent(wallet: wallet));
          }
        });
      });
    });

    on<AddMoneyErrorEvent>((event, emit) async {
      logWithColor(
          message: '|=======================> Failed Payment', color: 'red');
      await DatastoreServices.markFailedPayment(transaction: transaction!)
          .then((value) {
        transaction = value?.copyWith(status: TransactionStatus.FAILED);
        emit(AddMoneyFailed(wallet: _user.wallet!, transaction: transaction!));
      });
    });

    on<WalletUpdateSuccessEvent>((event, emit) {
      transaction = transaction?.copyWith(status: TransactionStatus.SUCCESSFUL);
      emit(AddMoneySuccess(transaction: transaction!, wallet: event.wallet));
    });

    on<WalletUpdateFailedEvent>((event, emit) async {
      await DatastoreServices.markWalletUpdateFail(transaction: transaction!)
          .then((tr) {
        transaction = tr?.copyWith(status: TransactionStatus.FAILED);
        emit(AddMoneyFailed(wallet: _user.wallet!, transaction: transaction!));
      });
    });
  }

  _checkOutPayment(User user, double amount) async {
    _razorpay.open({
      'amount': amount.toInt() * 100,
      'description': 'Add Money',
      'name': 'Tasvat Private Ltd.',
      'key': 'rzp_test_nxde3wSg0ubBiN',
      'prefill': {'contact': user.phone, 'email': user.email},
      'external': {
        'wallet': ['paytm', 'gpay']
      }
    });
  }

  _razorpayInit() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      add(AddMoneySuccessEvent(response: response, user: _user));
    });
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      add(AddMoneyErrorEvent(response: response));
    });
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
        (ExternalWalletResponse response) {
      safePrint(response.walletName);
    });
  }
}
