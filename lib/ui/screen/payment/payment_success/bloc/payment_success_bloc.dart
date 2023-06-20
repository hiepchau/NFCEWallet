import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:nfc_e_wallet/data/repositories/wallet_repo.dart';

part 'payment_success_event.dart';
part 'payment_success_state.dart';

class PaymentSuccessBloc extends Bloc<PaymentSuccessEvent, PaymentSuccessState> {
  PaymentSuccessBloc() : super(PaymentSuccessState()) {
    on<InitPaymentSuccessEvent>((event, emit) {
      final walletRepo = GetIt.instance.get<WalletRepo>();
    });
  }
}
