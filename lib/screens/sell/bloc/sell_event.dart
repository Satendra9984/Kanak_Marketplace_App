part of 'sell_bloc.dart';

class SellEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SellConfirmEvent extends SellEvent {
  final ExchangeRates rates;
  final User user;
  final List<UserBank> banks;
  final double quantity;
  SellConfirmEvent({
    required this.rates,
    required this.quantity,
    required this.user,
    required this.banks
  });
  @override
  List<Object> get props => [
    rates,
    user,
    banks,
    quantity
  ];
}

class ResetEvent extends SellEvent {
  @override
  List<Object> get props => [];
}

class ConfirmButtonPressed extends SellEvent {
  @override
  List<Object> get props => [];
}

class GoldDeductedEvent extends SellEvent {
  @override
  List<Object> get props => [];
}

class GoldDeductionFailed extends SellEvent {
  @override
  List<Object> get props => [];
}

class PaymentMethodChosen extends SellEvent {
  final int chosen;
  PaymentMethodChosen({
    required this.chosen
  });
  @override
  List<Object> get props => [
    chosen
  ];
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
  final SellInfo info;
  SellPurchaseSuccess({
    required this.info
  });
  @override
  List<Object> get props => [
    info
  ];
}

class SellPurchaseFailure extends SellEvent {
  @override
  List<Object> get props => [];
}

class MoneyAddedEvent extends SellEvent {
  @override
  List<Object> get props => [];
}