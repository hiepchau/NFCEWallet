part of 'payment_success_bloc.dart';

abstract class PaymentSuccessEvent {}

class InitPaymentSuccessEvent extends PaymentSuccessEvent{
  final Transaction transacion;
  InitPaymentSuccessEvent(this.transacion);
}
