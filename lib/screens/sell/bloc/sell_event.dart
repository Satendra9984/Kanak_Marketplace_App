part of 'sell_bloc.dart';

class SellEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SellConfirmEvent extends SellEvent {
  final ExchangeRates rates;
  final User user;
  final double quantity;
  SellConfirmEvent({
    required this.rates,
    required this.quantity,
    required this.user
  });
  @override
  List<Object> get props => [
    rates,
    user,
    quantity
  ];
}

class ConfirmButtonPressed extends SellEvent {
  final Transaction transaction;
  ConfirmButtonPressed({
    required this.transaction
  });
  @override
  List<Object> get props => [
    transaction
  ];
}

class PaymentMethodChosen extends SellEvent {
  final PaymentMethodChosen method;
  PaymentMethodChosen({
    required this.method
  });
  @override
  List<Object> get props => [];
}

class ChoosePaymentMethod extends SellEvent {
  @override
  List<Object> get props => [];
}

class TickEvent extends SellEvent {
  final int seconds;
  TickEvent({
    required this.seconds
  });
  @override
  List<Object> get props => [
    seconds
  ];
}

class PendingTransactionAdded extends SellEvent {
  @override
  List<Object> get props => [];
}

class SellPurchaseSuccess extends SellEvent {
  @override
  List<Object> get props => [];
}

class SellPurchaseFailure extends SellEvent {
  @override
  List<Object> get props => [];
}

class SellSuccess extends SellEvent {
  @override
  List<Object> get props => [];
}

class SellFailure extends SellEvent {
  @override
  List<Object> get props => [];
}

class Wallet extends SellEvent {

}