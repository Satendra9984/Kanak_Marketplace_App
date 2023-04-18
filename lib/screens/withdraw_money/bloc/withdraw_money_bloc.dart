import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'withdraw_money_event.dart';
part 'withdraw_money_state.dart';

class WithdrawMoneyBloc extends Bloc<WithdrawMoneyEvent, WithdrawMoneyState> {
  WithdrawMoneyBloc() : super(WithdrawMoneyInitial()) {
    on<WithdrawMoneyEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
