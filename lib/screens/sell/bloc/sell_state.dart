part of 'sell_bloc.dart';

@immutable
abstract class SellState extends Equatable {}

class SellInitial extends SellState {
  @override
  List<Object> get props => [];
}

class SellProgress extends SellState {
  final double progress;
  SellProgress({
    required this.progress
  });
  @override
  List<Object> get props => [];
}
