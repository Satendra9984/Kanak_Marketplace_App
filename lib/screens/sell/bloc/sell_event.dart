part of 'sell_bloc.dart';

abstract class SellEvent extends Equatable {
  const SellEvent();
  @override
  List<Object> get props => [];
}

class SellConfirmEvent extends SellEvent {
  final ExchangeRates rates;
  final User user;
  final double quantity;
  const SellConfirmEvent({
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
  const ConfirmButtonPressed({
    required this.transaction
  });
  @override
  List<Object> get props => [
    transaction
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
