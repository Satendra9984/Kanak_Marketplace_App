part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PhoneNumberChangedEvent extends SignUpEvent {
  final String phone;
  PhoneNumberChangedEvent({required this.phone});
  @override
  List<Object?> get props => [phone];
}

class EmailChangedEvent extends SignUpEvent {
  final String email;
  EmailChangedEvent({required this.email});
  @override
  List<Object?> get props => [email];
}

class PasswordChangedEvent extends SignUpEvent {
  final String password;
  PasswordChangedEvent({required this.password});
  @override
  List<Object?> get props => [password];
}