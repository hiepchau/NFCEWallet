part of 'payment_success_bloc.dart';

abstract class PaymentSuccessEvent {}

class InitPaymentSuccessEvent extends PaymentSuccessEvent{
  final Map<String, dynamic> transacion;
  InitPaymentSuccessEvent(this.transacion);
}
