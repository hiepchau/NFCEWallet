part of 'payment_confirm_bloc.dart';

class PaymentConfirmState {
  final String amount;
  final String receiverName;
  final String receiverWalletId;
  final String phoneNumber;
  final String? message;
  final bool? isSuccess;
  final String? bank;
  PaymentConfirmState(
      {this.amount = "",
      this.receiverName = "",
      this.phoneNumber = "",
      this.receiverWalletId = "",
      this.message = "",
      this.bank="",
      this.isSuccess});
  PaymentConfirmState copyWith(
      {String? amount,
      String? receiverName,
      String? phoneNumber,
      String? message,
      String? receiverWalletId,
      bool? isSuccess,
      String? bank,}) {
    return PaymentConfirmState(
        amount: amount ?? this.amount,
        receiverName: receiverName ?? this.receiverName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        message: message ?? this.message,
        receiverWalletId: receiverWalletId ?? this.receiverWalletId,
        isSuccess: isSuccess ?? this.isSuccess,
        bank: bank ?? this.bank);
  }
}

class PaymentConfirmInitial extends PaymentConfirmState {}

class PaymentLoadingState extends PaymentConfirmState {}

class PaymentUpdatedState extends PaymentConfirmState {
  PaymentUpdatedState(
      {required amount, required receiver, required phoneNumber, message});
}

class PaymentSentState extends PaymentConfirmState {}

class PaymentErrorState extends PaymentConfirmState {
  PaymentErrorState(message);
}
