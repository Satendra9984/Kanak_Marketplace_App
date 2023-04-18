part of 'withdraw_money_bloc.dart';

@immutable
abstract class WithdrawMoneyEvent extends Equatable {}

class WithdrawMoneyInitialEvent extends WithdrawMoneyEvent {
  @override
  // Implement props
  List<Object?> get props => [];
}
