abstract class PaymentEvent {}

class UpdateAmountEvent extends PaymentEvent {
  final String newAmount;

  UpdateAmountEvent(this.newAmount);
}

class UpdateReceiverEvent extends PaymentEvent {
  final String newReceiver;

  UpdateReceiverEvent(this.newReceiver);
}

class UpdatePhoneNumberEvent extends PaymentEvent {
  final String newPhoneNumber;

  UpdatePhoneNumberEvent(this.newPhoneNumber);
}

class InitializePaymentEvent extends PaymentEvent {
  final String amount;
  final String receiver;
  final String phoneNumber;
  final String? message;

  InitializePaymentEvent({required this.amount, required this.receiver, required this.phoneNumber, this.message});
}