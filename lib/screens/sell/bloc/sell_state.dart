part of 'sell_bloc.dart';

abstract class SellState extends Equatable {
  @override
  List<Object> get props => [];
}

class SellInitial extends SellState {
  final ExchangeRates rates;
  final User user;
  final ExchangeRates transaction;
  SellInitial({
    required this.transaction,
    required this.rates,
    required this.user
  });
  @override
  List<Object> get props => [
    rates, user, transaction
  ];
}

class SellProgress extends SellState {
  @override
  List<Object> get props => [];
}