import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvents, RegistrationStates> {
  RegistrationBloc() : super(RegistrationInitialState()) {
    on<RegistrationInitial>((event, emit) {});
  }
}
