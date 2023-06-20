part of 'otp_bloc.dart';

abstract class OtpEvent {}

class SubmitOtpEvent extends OtpEvent {
  final String otp;
  final String phoneNumber;
  SubmitOtpEvent(this.otp, this.phoneNumber);
}

class ResendOtpEvent extends OtpEvent {}
