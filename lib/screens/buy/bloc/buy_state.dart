part of 'buy_bloc.dart';

@immutable
abstract class BuyState extends Equatable {
  final CustomTimerController _timerController;
  final Transaction? transaction;
  const BuyState({
    this.transaction
  });
}

class BuyInitial extends BuyState {
  @override
  List<Object?> get props => [];
}

class BuyProccessing extends BuyState {
  final double progress;
  const BuyProccessing({
    required this.progress
  });
  @override
  List<Object?> get props => [];
}

class BuyCompletedState extends BuyState {}

class BuyErrorState extends BuyState {}
