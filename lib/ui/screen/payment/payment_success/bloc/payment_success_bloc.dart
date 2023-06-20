import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_success_event.dart';
part 'payment_success_state.dart';

class PaymentSuccessBloc extends Bloc<PaymentSuccessEvent, PaymentSuccessState> {
  PaymentSuccessBloc() : super(PaymentSuccessInitial()) {
    on<InitPaymentSuccessEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
