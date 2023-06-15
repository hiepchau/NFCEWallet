import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<Submitted>(_onSubmitted);
  }

  void _onPhoneNumberChanged(PhoneNumberChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  Future<void> _onSubmitted(Submitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(submissionInProgress: true));
    try {
      await signInWithCredentials(event.phoneNumber, event.password);
      emit(state.copyWith(submissionSuccess: true));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    } finally {
      emit(state.copyWith(submissionInProgress: false));
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