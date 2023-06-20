part of 'payment_success_bloc.dart';

class PaymentSuccessState {
  final String sender;
  final String recipient;
  final String message;
  final String paymentTime;

  PaymentSuccessState(
      {this.sender = "",
      this.recipient = "",
      this.message = "",
      this.paymentTime = ""});
  PaymentSuccessState copyWith({
    String? sender,
    String? recipient,
    String? message,
    String? paymentTime,
  }) {
    return PaymentSuccessState(
      sender: sender ?? this.sender,
      recipient: recipient ?? this.recipient,
      paymentTime: paymentTime ?? this.paymentTime,
      message: message ?? this.message,
    );
  }
}

class PaymentSuccessInitial extends PaymentSuccessState {}
