import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
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
        print(event.otp);
        final data =
            await authenticator.verifyOtp(event.phoneNumber, event.otp);
        if (data != null) {
          if (data["type"] == "REGISTER") {
            emit(OtpSuccess(type: "REGISTER", data: data));
          } else if (data["type"] == "TRANSFER_TRANSACTION") {
            emit(OtpSuccess(type: "TRANSFER_TRANSACTION", data: data["from_Transaction"]));
          } else if (data["type"] == "TRANSACTION") {
            emit(OtpSuccess(type: "TRANSACTION", data: data["transaction"]));
          }
        } else {
          emit(OtpFailure("Invalid OTP"));
        }
      } catch (error) {
        if(error is DioException){
          print(error.message);
        }
        emit(OtpFailure(error.toString()));
      }
    });
    on<ResendOtpEvent>((event, emit) {
      //resend otp
    });
  }
}
