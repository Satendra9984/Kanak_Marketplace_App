part of 'sell_bloc.dart';

abstract class SellEvent extends Equatable {
  const SellEvent();
  @override
  List<Object> get props => [];
}

class SellInitEvent extends SellEvent {
  @override
  List<Object> get props => [];
}

class ConfirmButtonPressed extends SellEvent {
  @override
  List<Object> get props => [];
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