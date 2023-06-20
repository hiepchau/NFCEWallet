part of 'payment_success_bloc.dart';

abstract class PaymentSuccessEvent {}

class InitPaymentSuccessEvent extends PaymentSuccessEvent{
  final String sender;
  final String recipient;
  final String message;
  final String paymentTime;
  InitPaymentSuccessEvent(this.sender, this.recipient, this.message, this.paymentTime);
}
