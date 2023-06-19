import 'otp_event.dart';
import 'otp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OtpService otpService;

  OtpBloc({required this.otpService}) : super(OtpInitial());

  @override
  Stream<OtpState> mapEventToState(OtpEvent event) async* {
    if (event is SubmitOtp) {
      yield OtpLoading();
      try {
        final isValid = await otpService.validateOtp(event.otp);
        if (isValid) {
          yield OtpSuccess();
        } else {
          yield OtpFailure("Invalid OTP");
        }
      } catch (error) {
        yield OtpFailure(error.toString());
      }
    } else if (event is ResendOtp) {
      try {
        await otpService.resendOtp();
        // Yield a state to notify the UI about the resend action
        // yield OtpResent();
      } catch (error) {
        yield OtpFailure(error.toString());
      }
    }
  }
}

class OtpService {
  Future<bool> validateOtp(String otp) async {
    // Simulate a network request
    await Future.delayed(Duration(seconds: 2));

    // Consider the OTP as valid if it's "123456"
    if (otp == '123456') {
      return true;
    } else {
      throw Exception('Invalid OTP');
    }
  }

  Future<void> resendOtp() async {
    // Simulate a network request
    await Future.delayed(Duration(seconds: 2));
    return;
  }
}
