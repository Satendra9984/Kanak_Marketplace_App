part of 'buy_bloc.dart';

@immutable
abstract class BuyState {}

class BuyInitial extends BuyState {}

class BuyingState extends BuyState {}

class BuyCompletedState extends BuyState {
  // data
}

class BuyErrorState extends BuyState {}
