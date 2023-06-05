// login_event.dart
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class Submitted extends LoginEvent {
  final String email;
  final String password;

  const Submitted(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SwitchSignInMethod extends LoginEvent {} // Newly added

