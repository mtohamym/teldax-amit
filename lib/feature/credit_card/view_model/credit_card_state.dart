part of 'credit_card_cubit.dart';

@immutable
abstract class CreditCardState {}

class CreditCardInitial extends CreditCardState {}

class CreditCardAdded extends CreditCardState {}

class CreditCardError extends CreditCardState {}

class CreditCardLoading extends CreditCardState {}
