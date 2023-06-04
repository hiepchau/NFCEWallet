// login_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is PasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is Submitted) {
      yield state.copyWith(submissionInProgress: true);
      try {
        // Call your authentication logic
        yield state.copyWith(submissionSuccess: true);
      } catch (e) {
        yield state.copyWith(errorMessage: 'An error occurred');
      } finally {
        yield state.copyWith(submissionInProgress: false);
      }
    } else if (event is SwitchSignInMethod) { // Newly added
      yield state.copyWith(isSigningInWithPhoneNumber: !state.isSigningInWithPhoneNumber);
    }
  }
}
