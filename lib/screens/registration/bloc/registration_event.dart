part of 'registration_bloc.dart';

abstract class RegistrationEvents {}

class RegistrationInitial extends RegistrationEvents {}

class AlreadyRegisteres extends RegistrationEvents {}

class CheckingBankDetails extends RegistrationEvents {}

class AddingBankDetails extends RegistrationEvents {}

class CheckingAddressDetails extends RegistrationEvents {}

class AddingAddressDetails extends RegistrationEvents {}

class CheckingKYCDetails extends RegistrationEvents {}

class AddingKYCDetails extends RegistrationEvents {}
