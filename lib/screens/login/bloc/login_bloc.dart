import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/services/auth_services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  late GlobalKey<FormState> formKey;
  LoginBloc({required this.authRepository})
      : super(const LoginState(
            status: LoginStatus.initial, password: '', phone: '')) {
    // phone number change event
    on<PhoneNumberChangedEvent>(
        (PhoneNumberChangedEvent event, Emitter<LoginState> emit) {
      emit(state.copyWith(phone: event.phone, status: LoginStatus.filling));
    });

    // password change event
    on<PasswordChangedEvent>(
        (PasswordChangedEvent event, Emitter<LoginState> emit) {
      emit(state.copyWith(
          password: event.password, status: LoginStatus.filling));
    });

    // login button pressed event
    on<LoginButtonPressedEvent>(
        (LoginButtonPressedEvent event, Emitter<LoginState> emit) async {
      if (formKey.currentState!.validate()) {
        safePrint(state.phone);
        safePrint(state.password);
        await authRepository
            .signInWithPhoneAndPassword(
                phone: state.phone, password: state.password)
            .then((result) {
          safePrint('Done');
          emit(state.copyWith(status: LoginStatus.success));
        }).catchError((err) {
          emit(state.copyWith(
              errMsg: err.toString(), status: LoginStatus.error));
        });
      } else {
        emit(state.copyWith(status: LoginStatus.invalid));
      }
    });

    // login restart/logout event
    on<LoginRestartEvent>((event, emit) async {
      emit(state.copyWith(status: LoginStatus.initial));
    });

    // // logout event
    // on<LogOutEvent> ((event, emit) {
    //   emit(state.copyWith(status: LoginStatus.initial));
    // });
  }
  void addFormKey(GlobalKey<FormState> key) {
    formKey = key;
  }
}
