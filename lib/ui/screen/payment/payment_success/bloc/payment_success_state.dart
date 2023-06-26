part of 'payment_success_bloc.dart';

class PaymentSuccessState {
  final String sender;
  final String recipient;
  final String message;
  final String paymentTime;
  final String amount;
  final String phoneNumber;
  final String? type;

  PaymentSuccessState(
      {this.sender = "",
      this.recipient = "",
      this.message = "",
      this.paymentTime = "",
      this.amount = "",
      this.phoneNumber = "",
      this.type = "",});
  PaymentSuccessState copyWith({
    String? sender,
    String? recipient,
    String? message,
    String? paymentTime,
    String? amount,
    String? phoneNumber,
    String? type,
  }) {
    return PaymentSuccessState(
      sender: sender ?? this.sender,
      recipient: recipient ?? this.recipient,
      paymentTime: paymentTime ?? this.paymentTime,
      message: message ?? this.message,
      amount: amount ?? this.amount,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      type: type ?? this.type,
    );
  }
}

class PaymentSuccessInitial extends PaymentSuccessState {}
