part of 'sell_bloc.dart';

abstract class SellState extends Equatable {
  final ExchangeRates rates;
  final User user;
  final ExchangeRates _rates;
  
  const SellState();
  @override
  List<Object> get props => [];
}

class SellInitial extends SellState {
  @override
  List<Object> get props => [];
}

class SellProgress extends SellState {
  @override
  List<Object> get props => [];
}