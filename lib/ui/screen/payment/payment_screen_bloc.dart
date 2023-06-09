import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_screen_event.dart';
import 'payment_screen_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(ThemeState(0));

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    if (event is ChangeThemeEvent) {
      yield ThemeState(event.themeIndex);
    } else if (event is ChangeMessageEvent) {
      yield MessageState(event.message);
    } else if (event is ChangeAmountEvent) {
      yield AmountState(event.amount);
    }
  }
}

