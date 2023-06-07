// login_event.dart
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PhoneNumberChanged extends LoginEvent {
  final String phoneNumber;

  const PhoneNumberChanged(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class Submitted extends LoginEvent {
  final String phoneNumber;
  final String password;

  const Submitted(this.phoneNumber, this.password);

  @override
  List<Object> get props => [phoneNumber, password];
}

class SwitchSignInMethod extends LoginEvent {} // Newly added

