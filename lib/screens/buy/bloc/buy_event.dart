part of 'buy_bloc.dart';

class BuyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RateConfirmEvent extends BuyEvent {
  final double quantity;
  final User user;
  final ExchangeRates exchangeRates;
  RateConfirmEvent({
    required this.user,
    required this.exchangeRates,
    required this.quantity
  });
  @override
  List<Object?> get props => [
    exchangeRates,
    user,
    quantity
  ];
}

class ConfirmButtonPressedEvent extends BuyEvent {
  final Transaction transaction;
  ConfirmButtonPressedEvent({required this.transaction});
  @override
  List<Object?> get props => [transaction];
}

class PaymentErrorEvent extends BuyEvent {
  final PaymentFailureResponse response;
  PaymentErrorEvent({required this.response});
  @override
  List<Object?> get props => [response];
}

class PaymentSuccessEvent extends BuyEvent {
  final PaymentSuccessResponse response;
  PaymentSuccessEvent({required this.response});
  @override
  List<Object?> get props => [response];
}

class PurchaseErrorEvent extends BuyEvent {
  final String? message;
  PurchaseErrorEvent({this.message});
  @override
  List<Object?> get props => [message];
}

class PurchaseSuccessEvent extends BuyEvent {
  final BuyInfo info;
  PurchaseSuccessEvent({required this.info});
  @override
  List<Object?> get props => [info];
}

class WalletUpdateSuccessEvent extends BuyEvent {
  @override
  List<Object?> get props => [];
}

class WalletUpdateFailedEvent extends BuyEvent {
  @override
  List<Object?> get props => [];
}

class ConfirmTimeountEvent extends BuyEvent {
  @override
  List<Object?> get props => [];
}

class PaymentTimeountEvent extends BuyEvent {
  @override
  List<Object?> get props => [];
}

class TotalTimeoutEvent extends BuyEvent {
  @override
  List<Object?> get props => [];
}
