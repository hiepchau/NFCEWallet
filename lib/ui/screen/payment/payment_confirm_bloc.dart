import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_e_wallet/ui/screen/payment/payment_confirm_event.dart';
import 'package:nfc_e_wallet/ui/screen/payment/payment_confirm_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitialState());

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    if (event is InitializePaymentEvent) {
      yield PaymentUpdatedState(amount: event.amount, receiver: event.receiver, phoneNumber: event.phoneNumber, message: event.message);
    }
    else if (event is UpdateAmountEvent) {
      yield PaymentUpdatedState(amount: event.newAmount, receiver: "receiverName", phoneNumber: "phoneNumber");
    }
  }
}
