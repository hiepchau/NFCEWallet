// login_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is PhoneNumberChanged) {
      yield state.copyWith(phoneNumber: event.phoneNumber);
    } else if (event is Submitted) {
      yield state.copyWith(submissionInProgress: true);
      try {
        // Call your authentication logic
        await signInWithCredentials(event.phoneNumber, event.password);
        yield state.copyWith(submissionSuccess: true);
      } catch (e) {
        yield state.copyWith(errorMessage: e.toString());
      } finally {
        yield state.copyWith(submissionInProgress: false);
      }
    }
  }

  Future<void> signInWithCredentials(String phoneNumber,
      String password) async {
    // Call  authentication service/API
    // Fake call:
    bool isAuthenticated = await Future.delayed(
        Duration(seconds: 1), () => true);

    if (!isAuthenticated) {
      throw Exception('Failed to authenticate');
    }
  }
}