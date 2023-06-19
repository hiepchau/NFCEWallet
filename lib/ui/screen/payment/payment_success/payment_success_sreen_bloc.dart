import 'package:flutter_bloc/flutter_bloc.dart';

import 'payment_success_sreen_event.dart';
import 'payment_success_sreen_state.dart';

class PaymentSuccessBloc extends Bloc<PaymentSuccessEvent, PaymentSuccessState> {
  final String sender;
  final String recipient;
  final String phoneNumber;
  final String message;
  final String paymentTime;

  PaymentSuccessBloc({
    required this.sender,
    required this.recipient,
    required this.phoneNumber,
    required this.message,
    required this.paymentTime,
  }) : super(PaymentSuccessLoadingState());

  @override
  Stream<PaymentSuccessState> mapEventToState(PaymentSuccessEvent event) async* {
    if (event is LoadPaymentSuccessInfo) {
      // Replace with actual success condition
      bool success = true;
      if (success) {
        yield PaymentSuccessLoadedState(
          sender: this.sender,
          recipient: this.recipient,
          phoneNumber: this.phoneNumber,
          message: this.message,
          paymentTime: this.paymentTime,
        );
      } else {

      }
    } else if (event is ClosePaymentSuccess) {

    }
  }
}


