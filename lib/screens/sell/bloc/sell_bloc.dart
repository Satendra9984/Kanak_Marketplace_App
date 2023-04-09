import 'dart:async';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/models/gold_models/rate_model.dart';
import 'package:tasvat/services/datastore_services.dart';
import 'package:tasvat/services/gold_services.dart';

part 'sell_event.dart';
part 'sell_state.dart';

class SellBloc extends Bloc<SellEvent, SellState> {
  late User _user;
  late Timer _timer;
  late String _bankId;

  SellBloc() : super(const SellState(
    status: SellStatus.initial
  )) {
    on<SellConfirmEvent>((event, emit) {
      _user = event.user;
      emit(state.copyWith(
        remainingTime: 180,
        rates: event.rates,
        transaction: Transaction(
              blockId: event.rates.blockId,
              lockPrice: event.rates.gSell,
              type: TransactionType.SELL,
              status: TransactionStatus.PENDING,
              quantity: event.quantity,
              amount: _calculateAmountWithTax(
                event.rates,
                event.quantity
              ),
              userId: event.user.id,
              dateTime: TemporalDateTime.now(),
              transactionReceiverId: event.user.id,
              transactionSenderId: '6f6d07c8-9dab-485d-9423-4b16152af571'
        )
      ));
      _timer = Timer.periodic(const Duration(
        seconds: 1
      ), (timer) {
        if (state.remainingTime! > 0) {
          add(TickEvent(seconds: state.remainingTime! - 1));
        } else {
          _timer.cancel();
        }
      });
    });


    on<ConfirmButtonPressed>((event, emit) async {
      add(ChoosePaymentMethod());
    });

    on<ChoosePaymentMethod>((event, emit) async {
      await GoldServices.getUserBankAccounts(userId: _user.id).then((banks) async {
        safePrint(banks.length);
      });
    });

    on<TickEvent>((event, emit) {
      emit(state.copyWith(remainingTime: event.seconds));
    });


    on<PaymentMethodChosen>((event, emit) async {
      emit(state.copyWith(status: SellStatus.progress));
      await DatastoreServices.addPendingTransaction(
        transaction: state.transaction!
      )
      .then((tx) async {
        add(PendingTransactionAdded());
      });
    });


    on<PendingTransactionAdded>((event, emit) async {
      await GoldServices.sellGold(
        user: _user,
        bankId: _bankId,
        transaction: state.transaction!,
        rate: state.rates!
      ).then((value) {
        if (value == null) {
          // add(Pur)
        }
      });
    });
  }
  double _calculateAmountWithTax(ExchangeRates rates, double quantity) {
    double taxRate = 100;
    for (Tax tax in rates.taxes!) {
      taxRate += double.parse(tax.taxPerc);
    }
    double amount = quantity *
            double.parse(rates.gSell!) *
            taxRate /
            100;
    return amount;
  }
}
