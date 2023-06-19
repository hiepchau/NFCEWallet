part of 'payment_confirm_bloc.dart';

class PaymentConfirmState{
  final String amount;
  final String receiver;
  final String phoneNumber;
  final String? message;
  PaymentConfirmState(
      {this.amount="",
       this.receiver="",
       this.phoneNumber="",
      this.message=""});
  PaymentConfirmState copyWith(
      {String? amount, String? receiver, String? phoneNumber, String? message}) {
    return PaymentConfirmState(
        amount: amount ?? this.amount,
        receiver: receiver ?? this.receiver,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        message: message ?? this.message);
  }
}

class PaymentConfirmInitial extends PaymentConfirmState {}
class PaymentLoadingState extends PaymentConfirmState {}
class PaymentUpdatedState extends PaymentConfirmState {
  PaymentUpdatedState(
      {required amount,
      required receiver,
      required phoneNumber,
      message});
}
class PaymentErrorState extends PaymentConfirmState {

  PaymentErrorState(message);
}

