abstract class OtpEvent {}

class SubmitOtp extends OtpEvent {
  final String otp;

  SubmitOtp(this.otp);
}

class ResendOtp extends OtpEvent {}
