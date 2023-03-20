part of 'buy_bloc.dart';

@immutable
abstract class BuyState {}

class BuyInitial extends BuyState {}

class BuyingState extends BuyState {}

class BuyCompletedState extends BuyState {}

class BuyErrorState extends BuyState {}
