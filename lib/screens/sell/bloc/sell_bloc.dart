import 'dart:async';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/models/gold_models/bank_response.dart';
import 'package:tasvat/models/gold_models/rate_model.dart';
import 'package:tasvat/models/gold_models/sell_info_model.dart';
import 'package:tasvat/services/datastore_services.dart';
import 'package:tasvat/services/gold_services.dart';
import 'package:tasvat/utils/loggs.dart';

part 'sell_event.dart';
part 'sell_state.dart';

class SellBloc extends Bloc<SellEvent, SellState> {
  late User _user;
  late Timer _timer;

  SellBloc() : super(const SellState(status: SellStatus.initial)) {
    on<ResetEvent>((event, emit) {
      logWithColor(message: 'RESET EVENT');
      _user = User();
      emit(const SellState(
          transaction: null,
          rates: null,
          remainingTime: 180,
          status: SellStatus.initial));
    });
    on<SellConfirmEvent>((event, emit) {
      _user = event.user;
      emit(state.copyWith(
          banks: event.banks,
          chosenBank: 0,
          remainingTime: 180,
          rates: event.rates,
          transaction: Transaction(
              blockId: event.rates.blockId,
              lockPrice: event.rates.gSell,
              type: TransactionType.SELL,
              status: TransactionStatus.PENDING,
              quantity: event.quantity,
              amount: _calculateAmountWithTax(event.rates, event.quantity),
              userId: event.user.id,
              dateTime: TemporalDateTime.now(),
              transactionReceiverId: event.user.id,
              transactionSenderId: '6f6d07c8-9dab-485d-9423-4b16152af571')));
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (state.remainingTime! > 0) {
          add(TickEvent(seconds: state.remainingTime! - 1));
        } else {
          _timer.cancel();
        }
      });
    });

    on<ConfirmButtonPressed>((event, emit) async {
      emit(state.copyWith(status: SellStatus.progress));
      await DatastoreServices.addPendingTransaction(
              transaction: state.transaction!)
          .then((tx) {
        if (tx == null) {
          return;
        }
        emit(state.copyWith(
            transaction: tx.copyWith(txId: state.transaction!.id)));
        add(PendingTransactionAdded());
      });
    });

    on<ChoosePaymentMethod>((event, emit) async {
      emit(state.copyWith(status: SellStatus.choose));
    });

    on<TickEvent>((event, emit) {
      emit(state.copyWith(remainingTime: event.seconds));
    });

    on<PaymentMethodChosen>((event, emit) async {
      emit(
          state.copyWith(chosenBank: event.chosen, status: SellStatus.initial));
    });

    on<PendingTransactionAdded>((event, emit) async {
      logWithColor(message: 'PENDING TRANSACTION ADDED', color: 'green');
      await DatastoreServices.updateWalletGoldBalance(
              wallet: _user.wallet!,
              goldBalance:
                  _user.wallet!.gold_balance! - state.transaction!.quantity!)
          .then((updatedWallet) {
        if (updatedWallet == null) {
          return;
        }
        _user = _user.copyWith(wallet: updatedWallet);
        add(GoldDeductedEvent());
      });
    });

    on<GoldDeductedEvent>((event, emit) async {
      logWithColor(message: 'GOLD DEDUCTED FROM WALLET', color: 'green');
      await GoldServices.sellGold(
              user: _user,
              bankId: state.banks![state.chosenBank!].userBankId,
              transaction: state.transaction!,
              rate: state.rates!)
          .then((info) {
        if (info == null) {
          return;
        }
        add(SellPurchaseSuccess(info: info));
      }).catchError((err) {
        add(SellPurchaseFailure());
      });
    });

    on<SellPurchaseSuccess>((event, emit) async {
      logWithColor(message: 'SUCCESSFUL GOLD SELL', color: 'green');
      emit(state.copyWith(
          transaction: state.transaction!.copyWith(
        gpTxId: event.info.transactionId,
        gold_balance: double.parse(event.info.goldBalance),
      )));
      if (state.chosenBank == 0) {
        await DatastoreServices.updateWalletBalance(
                wallet: _user.wallet!,
                balance: _user.wallet!.balance! + state.transaction!.amount!)
            .then((updatedWallet) {
          if (updatedWallet == null) {
            return;
          }
          _user = _user.copyWith(wallet: updatedWallet);
          emit(state.copyWith(
              transaction:
                  state.transaction!.copyWith(balance: updatedWallet.balance)));
          add(MoneyAddedEvent());
        });
      } else {
        await DatastoreServices.markSuccessfulPurchase(
                transaction: state.transaction!)
            .then((tx) {
          if (tx == null) {
            return;
          }
          _user = _user.copyWith(
              wallet: _user.wallet!.copyWith(
            balance: state.transaction!.balance,
            gold_balance: state.transaction!.gold_balance,
          ));
          logWithColor(message: 'SELL SUCCESS', color: 'green');
          emit(state.copyWith(status: SellStatus.success));
        });
      }
    });
    on<MoneyAddedEvent>((event, emit) async {
      logWithColor(message: 'MONEY ADDED EVENT', color: 'green');
      await DatastoreServices.markSuccessfulPurchase(
        transaction: state.transaction!,
      ).then((tx) {
        if (tx == null) {
          return;
        }
        logWithColor(message: 'SELL SUCCESS', color: 'green');
        emit(state.copyWith(status: SellStatus.success));
      });
    });
    on<SellPurchaseFailure>((event, emit) async {
      await DatastoreServices.markFailedPurchase(
              transaction: state.transaction!)
          .then((tx) {
        logWithColor(message: 'SELL FAILURE', color: 'red');
        emit(state.copyWith(status: SellStatus.failed));
      });
    });
  }

  double _calculateAmountWithTax(ExchangeRates rates, double quantity) {
    double taxRate = 100;
    for (Tax tax in rates.taxes!) {
      taxRate += double.parse(tax.taxPerc);
    }
    double amount = quantity * double.parse(rates.gSell!) * taxRate / 100;
    return amount;
  }
}
