part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PhoneNumberChangedEvent extends LoginEvent {
  final String phone;
  PhoneNumberChangedEvent({required this.phone});
  @override
  List<Object?> get props => [phone];
}

class PasswordChangedEvent extends LoginEvent {
  final String password;
  PasswordChangedEvent({required this.password});
  @override
  List<Object?> get props => [password];
}

class LoginButtonPressedEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class LoginRestartEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class LogOutEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}
