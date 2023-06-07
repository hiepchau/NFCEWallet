import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_screen_event.dart';
import 'payment_screen_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc()
      : super(PaymentInitialState());

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    if (event is SetThemeEvent) {
      yield PaymentUpdatedState(themeIndex: event.themeIndex);
    } else if (event is UpdateValueEvent) {
      yield PaymentUpdatedState(value: event.value);
    } else if (event is UpdateMessageEvent) {
      yield PaymentUpdatedState(message: event.message);
    } else if (event is ProceedPaymentEvent) {
      yield PaymentProceededState();
    }
  }
}
