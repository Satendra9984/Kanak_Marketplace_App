part of 'buy_bloc.dart';

@immutable
abstract class BuyEvent {}

class BuyConfirmButtonPressed extends BuyEvent {}

class BuyLoading extends BuyEvent {}

class BuyCompleted extends BuyEvent {}

class BuyError extends BuyEvent {}
