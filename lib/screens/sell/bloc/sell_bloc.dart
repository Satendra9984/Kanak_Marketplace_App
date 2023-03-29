import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/models/gold_models/rate_model.dart';
import 'package:tasvat/services/gold_services.dart';

part 'sell_event.dart';
part 'sell_state.dart';

class SellBloc extends Bloc<SellEvent, SellState> {
  late User _user;
  late Transaction _transaction;
  late ExchangeRates _rates;
  SellBloc() : super(SellInitial()) {
    on<SellInitEvent>((event, emit) {
      emit(SellInitial());

    });
    on<ConfirmButtonPressed>((event, emit) async {
      await GoldServices.sellGold(user: _user, bankId: , transaction: transaction, rate: rate)
    });
  }
}
