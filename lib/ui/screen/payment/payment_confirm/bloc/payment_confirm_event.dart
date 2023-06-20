part of 'payment_confirm_bloc.dart';

abstract class PaymentConfirmEvent {}

class UpdateAmountEvent extends PaymentConfirmEvent {
  final String newAmount;

  UpdateAmountEvent(this.newAmount);
}

class UpdateReceiverEvent extends PaymentConfirmEvent {
  final String newReceiver;

  UpdateReceiverEvent(this.newReceiver);
}

class UpdatePhoneNumberEvent extends PaymentConfirmEvent {
  final String newPhoneNumber;

  UpdatePhoneNumberEvent(this.newPhoneNumber);
}

class InitializePaymentEvent extends PaymentConfirmEvent {
  final String amount;
  final String phoneNumber;
  final String? message;

  InitializePaymentEvent(
      {required this.amount,
      required this.phoneNumber,
      this.message});
}

class SendPaymentEvent extends PaymentConfirmEvent {}