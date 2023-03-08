part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {}

class RegistrationInitial extends RegistrationEvent {
  @override
  List<Object?> get props => [];
}

class UploadDetailsPressed extends RegistrationEvent {
  @override
  List<Object?> get props => [];
}

class UploadedDetailsSuccess extends RegistrationEvent {
  @override
  List<Object?> get props => [];
}

class UploadedDetailsFail extends RegistrationEvent {
  @override
  List<Object?> get props => [];
}

class AadharUploadStart extends RegistrationEvent {
  @override
  List<Object?> get props => [];
}

class AadharUploadEnd extends RegistrationEvent {
  @override
  List<Object?> get props => [];
}

class PanUploadStart extends RegistrationEvent {
  @override
  List<Object?> get props => [];
}

class PanUploadEnd extends RegistrationEvent {
  @override
  List<Object?> get props => [];
}

class AddKycPressed extends RegistrationEvent {
  @override
  List<Object?> get props => [];
}

class KycUploadSuccess extends RegistrationEvent {
  @override
  List<Object?> get props => [];
}

class KycUploadFail extends RegistrationEvent {
  @override
  List<Object?> get props => [];
}

class AddBankAccount extends RegistrationEvent {
  @override
  List<Object?> get props => [];
}

class BankAccountUploadPressed extends RegistrationEvent {
  @override
  List<Object?> get props => [];
}

class BankAccountUploaSuccess extends RegistrationEvent {
  @override
  List<Object?> get props => [];
}

class BankAccountUploadFail extends RegistrationEvent {
  @override
  List<Object?> get props => [];
}