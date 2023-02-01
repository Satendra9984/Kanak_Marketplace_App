import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState(
    status: SignUpStatus.initial,
    email: '',
    phone: '',
    password: ''
  )) {
    on<SignUpEvent>((event, emit) {
      
    });
  }
}
