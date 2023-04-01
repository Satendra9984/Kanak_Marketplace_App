part of 'sell_bloc.dart';

abstract class SellState extends Equatable {
  @override
  List<Object> get props => [];
}

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