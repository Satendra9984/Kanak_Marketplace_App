import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_money_event.dart';
part 'add_money_state.dart';

class AddMoneyBloc extends Bloc<AddMoneyEvent, AddMoneyState> {
  AddMoneyBloc() : super(AddMoneyInitial()) {
    on<AddMoneyEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
