abstract class PaymentState {}

class PaymentInitialState extends PaymentState {}

class PaymentLoadingState extends PaymentState {}

class PaymentUpdatedState extends PaymentState {
  final String amount;
  final String receiver;
  final String phoneNumber;
  final String? message;
  PaymentUpdatedState({required this.amount, required this.receiver, required this.phoneNumber, this.message});
}

class PaymentErrorState extends PaymentState {
  final String message;

  PaymentErrorState(this.message);
}
