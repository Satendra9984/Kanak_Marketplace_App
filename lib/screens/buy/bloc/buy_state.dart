// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'buy_bloc.dart';

enum BuyStatus {
  initial,
  progress,
  success,
  failed,
  timeout
}

@immutable
class BuyState extends Equatable {
  final Transaction? transaction;
  final ExchangeRates? rates;
  final int? remainingTime;
  final BuyStatus? status;

  const BuyState({
    this.status,
    this.transaction,
    this.rates,
    this.remainingTime = 270
  });
  
  @override
  List<Object?> get props => [
    transaction,
    status,
    rates,
    remainingTime
  ];

  BuyState copyWith({
    Transaction? transaction,
    ExchangeRates? rates,
    int? remainingTime,
    BuyStatus? status
  }) {
    return BuyState(
      transaction: transaction ?? this.transaction,
      rates: rates ?? this.rates,
      remainingTime: remainingTime ?? this.remainingTime,
      status: status ?? this.status
    );
  }
}