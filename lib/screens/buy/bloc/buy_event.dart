part of 'buy_bloc.dart';

class BuyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RateConfirmEvent extends BuyEvent {
  final ExchangeRates exchangeRates;
  RateConfirmEvent({required this.exchangeRates});

  @override
  List<Object?> get props => [exchangeRates];
}

class ConfirmButtonPressedEvent extends BuyEvent {
  @override
  List<Object?> get props => [];
}

class PaymentErrorEvent extends BuyEvent {
  @override
  List<Object?> get props => [];
}

class PaymentSuccessEvent extends BuyEvent {
  @override
  List<Object?> get props => [];
}

class BuyErrorEvent extends BuyEvent {
  @override
  List<Object?> get props => [];
}

class BuySuccessEvent extends BuyEvent {
  @override
  List<Object?> get props => [];
}

class WalletUpdateSuccessEvent extends BuyEvent {
  @override
  List<Object?> get props => [];
}

class WalletUpdateFailedEvent extends BuyEvent {
  @override
  List<Object?> get props => [];
}
