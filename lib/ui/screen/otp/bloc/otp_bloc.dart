import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:nfc_e_wallet/data/repositories/authenticator.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial()) {
    on<SubmitOtpEvent>((event, emit) async {
      emit(OtpLoading());
      final authenticator = GetIt.instance.get<Authenticator>();
      try {
        final data =
            await authenticator.verifyOtp(event.phoneNumber, event.otp);
        if (data != null) {
          if (data["type"] == "register") {
            emit(OtpSuccess(type: "register", data: data));
          } else if (data["type"] == "transfer_transaction") {
            emit(OtpSuccess(type: "transfer_transaction", data: data["from_Transaction"]));
          } else if (data["type"] == "transaction") {
            emit(OtpSuccess(type: "transaction", data: data["transaction"]));
          }
        } else {
          emit(OtpFailure("Invalid OTP"));
        }
      } catch (error) {
        emit(OtpFailure(error.toString()));
      }
    });
    on<ResendOtpEvent>((event, emit) {
      //resend otp
    });
  }
}
