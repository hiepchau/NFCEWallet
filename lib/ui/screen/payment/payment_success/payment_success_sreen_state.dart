abstract class PaymentSuccessState {}

class PaymentSuccessLoadingState extends PaymentSuccessState {}

class PaymentSuccessLoadedState extends PaymentSuccessState {
  final String sender;
  final String recipient;
  final String phoneNumber;
  final String message;
  final String paymentTime;

  PaymentSuccessLoadedState({
    required this.sender,
    required this.recipient,
    required this.phoneNumber,
    required this.message,
    required this.paymentTime,
  });
}

class PaymentSuccessFailedState extends PaymentSuccessState {
  final String error;

  PaymentSuccessFailedState({required this.error});
}

