import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/models/gold_models/rate_model.dart';

part 'sell_event.dart';
part 'sell_state.dart';

class SellBloc extends Bloc<SellEvent, SellState> {
  SellBloc() : super(SellInitial()) {
    on<SellConfirmEvent>((event, emit) {

    });
    on<ConfirmButtonPressed>((event, emit) async {
    });
  }
}
