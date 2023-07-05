part of 'authenticate_bloc.dart';

@immutable
abstract class AuthenticationEvent {}
class LoginEvent extends AuthenticationEvent{
  final String phoneNumber;
  final String password;

  LoginEvent(this.phoneNumber, this.password);
}

