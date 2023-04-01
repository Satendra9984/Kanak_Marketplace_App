import 'dart:async';

import 'package:custom_timer/custom_timer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/models/gold_models/rate_model.dart';

part 'sell_event.dart';
part 'sell_state.dart';

class SellBloc extends Bloc<SellEvent, SellState> {
  late Transaction _transaction;
  late User _user;
  late ExchangeRates _rates;
  late Timer _timer;
  SellBloc() : super(SellInitial()) {
    on<SellConfirmEvent>((event, emit) {
      _rates = event.rates;
      _user = event.user;
    
    });
    on<ConfirmButtonPressed>((event, emit) async {
    });
  }
}
