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
  final List<UserBank>? banks;
  final int? chosenBank;

  const SellState({
    this.status,
    this.transaction,
    this.banks,
    this.rates,
    this.chosenBank,
    this.remainingTime
  });
  @override
  List<Object?> get props => [
    status,
    transaction,
    rates,
    banks,
    remainingTime,
    chosenBank
  ];

  SellState copyWith({
    Transaction? transaction,
    ExchangeRates? rates,
    int? remainingTime,
    SellStatus? status,
    List<UserBank>? banks,
    int? chosenBank
  }) {
    return SellState(
      transaction: transaction ?? this.transaction,
      rates: rates ?? this.rates,
      remainingTime: remainingTime ?? this.remainingTime,
      status: status ?? this.status,
      banks: banks ?? this.banks,
      chosenBank: chosenBank ?? this.chosenBank
    );
  }
}