import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_confirm_event.dart';
part 'payment_confirm_state.dart';

class PaymentConfirmBloc
    extends Bloc<PaymentConfirmEvent, PaymentConfirmState> {
  PaymentConfirmBloc() : super(PaymentConfirmState()) {
    on<InitializePaymentEvent>((event, emit) {
      emit(state.copyWith(
        amount: event.amount,
        receiver: event.receiver,
        phoneNumber: event.phoneNumber,
        message: event.message,
      ));
    });
    on<UpdateAmountEvent>((event, emit) {
      emit(state.copyWith(
        amount: event.newAmount,
      ));
    });
  }
}
