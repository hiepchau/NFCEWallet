part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class PhoneNumberChanged extends LoginState {
  final String phoneNumber;

  PhoneNumberChanged(this.phoneNumber);
}

class SubmissionInProgress extends LoginState {}

class SubmissionSuccess extends LoginState {}

class SubmissionFailure extends LoginState {
  final String errorMessage;

  SubmissionFailure(this.errorMessage);
}
