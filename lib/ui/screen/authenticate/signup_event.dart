part of 'signup_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class PhoneNumberChanged extends SignUpEvent {
  final String phoneNumber;

  const PhoneNumberChanged(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class PasswordChanged extends SignUpEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class RepeatPasswordChanged extends SignUpEvent {
  final String repeatPassword;

  const RepeatPasswordChanged(this.repeatPassword);

  @override
  List<Object> get props => [repeatPassword];
}

class SignUpSubmitted extends SignUpEvent {}
