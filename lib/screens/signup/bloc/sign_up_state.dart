part of 'sign_up_bloc.dart';

enum SignUpStatus {
  initial,
  filling,
  valid,
  invalid,
  error,
  success
}

class SignUpState extends Equatable {
  const SignUpState({
    required this.status,
    required this.email,
    required this.phone,
    required this.password,
    this.formError,
    this.errMsg
  });
  final SignUpStatus status;
  final String email;
  final String phone;
  final String password;
  final Map<String, String>? formError;
  final String? errMsg;
  @override
  List<Object?> get props => [
    status,
    phone,
    email,
    password,
    errMsg,
    formError,
    errMsg
  ];
}
