part of 'otp_bloc.dart';

abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {
  final String type;
  final Map<String, dynamic> data;
  OtpSuccess({this.type="", this.data=const {}});
}

class OtpFailure extends OtpState {
  final String error;

  OtpFailure(this.error);
}
