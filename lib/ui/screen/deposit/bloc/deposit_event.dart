part of 'deposit_bloc.dart';

class DepositEvent {
  const DepositEvent();
}

class ChangeAmountEvent extends DepositEvent{
  final String amount;
  ChangeAmountEvent(this.amount);
}

class SubmitEvent extends DepositEvent{}