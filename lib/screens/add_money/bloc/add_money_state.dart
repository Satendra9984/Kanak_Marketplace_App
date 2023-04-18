part of 'add_money_bloc.dart';

@immutable
abstract class AddMoneyState extends Equatable {}

class AddMoneyInitialState extends AddMoneyState {
  @override
  List<Object?> get props => [];
}

class AddMoneyProcessing extends AddMoneyState {
  final Transaction? transaction;

  AddMoneyProcessing({this.transaction});
  @override
  List<Object?> get props => [];

  AddMoneyProcessing copyWith({
    Transaction? transaction,
  }) {
    return AddMoneyProcessing(
      transaction: transaction ?? this.transaction,
    );
  }
}

class AddMoneySuccess extends AddMoneyState {
  final Transaction transaction;
  final Wallet wallet;
  AddMoneySuccess({
    required this.transaction,
    required this.wallet,
  });
  @override
  List<Object?> get props => [transaction];
}

class AddMoneyFailed extends AddMoneyState {
  final Transaction transaction;
  final Wallet wallet;

  AddMoneyFailed({required this.wallet, required this.transaction});
  @override
  List<Object?> get props => [];
}
