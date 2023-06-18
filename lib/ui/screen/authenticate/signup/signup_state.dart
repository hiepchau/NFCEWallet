part of 'signup_bloc.dart';

enum SignupStatus
{ Initial ,InvalidInfo, Success }

@immutable
abstract class SignupState {}

class SignupInfoState extends SignupState {
  SignupStatus signupStatus = SignupStatus.Initial;
  SignupInfoState({SignupStatus signupStatus = SignupStatus.Initial}) {
    this.signupStatus = signupStatus;
  }
}