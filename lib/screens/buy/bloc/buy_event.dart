part of 'buy_bloc.dart';

class BuyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResetEvent extends BuyEvent {
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
  List<Object?> get props => [exchangeRates, user, quantity];
}

class ConfirmButtonPressedEvent extends BuyEvent {
  ConfirmButtonPressedEvent();
  @override
  List<Object?> get props => [];
}

class PaymentMethodChosen extends BuyEvent {
  final PaymentMethod method;
  PaymentMethodChosen({
    required this.method
  });
  @override
  List<Object?> get props => [
    method
  ];
}

class ChoosePaymentMethod extends BuyEvent {
  @override
  List<Object?> get props => [];
}

class ChooseSheetClose extends BuyEvent {
  @override
  List<Object?> get props => [];
}

class PaymentErrorEvent extends BuyEvent {
  final PaymentFailureResponse? response;
  PaymentErrorEvent({this.response});
  @override
  List<Object?> get props => [response];
}

class PaymentSuccessEvent extends BuyEvent {
  final User user;
  final PaymentSuccessResponse? response;
  PaymentSuccessEvent({
    this.response,
    required this.user
  });
  @override
  List<Object?> get props => [response];
}

class TickEvent extends BuyEvent {
  final int seconds;
  TickEvent({
    required this.seconds
  });
  @override
  List<Object?> get props => [
    seconds
  ];
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
  final Wallet wallet;
  WalletUpdateSuccessEvent({
    required this.wallet
  });
  @override
  List<Object?> get props => [wallet];
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
