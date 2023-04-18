part of 'add_money_bloc.dart';

@immutable
abstract class AddMoneyEvent extends Equatable {}

class AddMoneyInitial extends AddMoneyEvent {
  final User user;
  AddMoneyInitial({required this.user});
  @override
  List<Object?> get props => [user];
}

class AddButtonPressedEvent extends AddMoneyEvent {
  final double amount;
  AddButtonPressedEvent({required this.amount});
  @override
  List<Object?> get props => [];
}

// pending tran added
class PendingTransactionAdded extends AddMoneyEvent {
  @override
  List<Object?> get props => [];
}

class AddMoneyErrorEvent extends AddMoneyEvent {
  final PaymentFailureResponse? response;
  AddMoneyErrorEvent({this.response});
  @override
  List<Object?> get props => [response];
}

class AddMoneySuccessEvent extends AddMoneyEvent {
  final User user;
  final PaymentSuccessResponse? response;
  AddMoneySuccessEvent({
    this.response,
    required this.user,
  });
  @override
  List<Object?> get props => [response];
}

class WalletUpdateSuccessEvent extends AddMoneyEvent {
  final Wallet wallet;
  WalletUpdateSuccessEvent({required this.wallet});
  @override
  List<Object?> get props => [wallet];
}

class WalletUpdateFailedEvent extends AddMoneyEvent {
  @override
  List<Object?> get props => [];
}
