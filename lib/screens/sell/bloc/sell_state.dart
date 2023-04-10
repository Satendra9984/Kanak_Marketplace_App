part of 'sell_bloc.dart';

enum SellStatus {
  initial,
  choose,
  progress,
  success,
  failed,
  timeout
}

class SellState extends Equatable {
  final Transaction? transaction;
  final ExchangeRates? rates;
  final int? remainingTime;
  final SellStatus? status;

  const SellState({
    this.status,
    this.transaction,
    this.rates,
    this.remainingTime = 270
  });
  @override
  List<Object?> get props => [
    status,
    transaction,
    rates,
    remainingTime
  ];

  SellState copyWith({
    Transaction? transaction,
    ExchangeRates? rates,
    int? remainingTime,
    SellStatus? status
  }) {
    return SellState(
      transaction: transaction ?? this.transaction,
      rates: rates ?? this.rates,
      remainingTime: remainingTime ?? this.remainingTime,
      status: status ?? this.status
    );
  }
}