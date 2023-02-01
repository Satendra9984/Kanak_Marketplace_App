part of 'login_bloc.dart';

enum LoginStatus {
  initial,
  filling,
  valid,
  invalid,
  error,
  success
}

class LoginState extends Equatable {
  final LoginStatus status;
  final String phone;
  final String password;
  final Map<String, String>? formError;
  final String? errMsg;
  const LoginState({
    required this.status,
    required this.phone,
    required this.password,
    this.errMsg,
    this.formError
  });
  @override
  List<Object?> get props => [
    status,
    phone,
    password,
    errMsg,
    formError
  ];
  LoginState copyWith({
    LoginStatus? status,
    String? phone,
    String? password,
    Map<String, String>? formError,
    String? errMsg}) {
    return LoginState(
      status: status ?? this.status,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      errMsg: errMsg ?? this.errMsg,
      formError: formError ?? this.formError
    );
  }
}