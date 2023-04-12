// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'buy_bloc.dart';

enum BuyStatus {
  initial,
  choose,
  progress,
  success,
  failed,
  timeout
}

enum PaymentMethod {
  wallet,
  external
}

@immutable
class BuyState extends Equatable {
  final Transaction? transaction;
  final ExchangeRates? rates;
  final int? remainingTime;
  final BuyStatus? status;
  final PaymentMethod? method;

  const BuyState({
    this.method,
    this.status,
    this.transaction,
    this.rates,
    this.remainingTime = 270
  });
  
  @override
  List<Object?> get props => [
    transaction,
    method,
    status,
    rates,
    remainingTime
  ];

  BuyState copyWith({
    Transaction? transaction,
    ExchangeRates? rates,
    int? remainingTime,
    BuyStatus? status,
    PaymentMethod? method
  }) {
    return BuyState(
      method: method ?? this.method,
      transaction: transaction ?? this.transaction,
      rates: rates ?? this.rates,
      remainingTime: remainingTime ?? this.remainingTime,
      status: status ?? this.status
    );
  }
}