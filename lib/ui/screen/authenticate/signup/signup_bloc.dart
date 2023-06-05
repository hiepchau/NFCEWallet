import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    // TODO: implement signup logic
    if (event is PhoneNumberChanged) {
      // validate phone number and yield new state
    } else if (event is PasswordChanged) {
      // validate password and yield new state
    } else if (event is RepeatPasswordChanged) {
      // validate repeated password and yield new state
    } else if (event is SignUpSubmitted) {
      // submit signup and yield new state
    }
  }
}
