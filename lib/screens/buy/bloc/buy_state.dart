part of 'buy_bloc.dart';

@immutable
abstract class BuyState extends Equatable {
}

class BuyInitial extends BuyState {
  @override
  List<Object?> get props => [];
}

class BuyProccessing extends BuyState {
  final double progress;
  BuyProccessing({
    required this.progress
  });
  @override
  List<Object?> get props => [];
}

class BuyCompletedState extends BuyState {
  @override
  List<Object?> get props => [];
}

class BuyErrorState extends BuyState {
  final FailType type;
  BuyErrorState({
    required this.type
  });
  @override
  List<Object?> get props => [
    type
  ];
}
