// login_state.dart
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String phoneNumber;
  final String password;
  final bool submissionInProgress;
  final bool submissionSuccess;
  final String errorMessage;

  const LoginState({
    this.phoneNumber = '',
    this.password = '',
    this.submissionInProgress = false,
    this.submissionSuccess = false,
    this.errorMessage = '',
  });

  LoginState copyWith({
    String? phoneNumber,
    String? password,
    bool? submissionInProgress,
    bool? submissionSuccess,
    String? errorMessage,
  }) {
    return LoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      submissionInProgress: submissionInProgress ?? this.submissionInProgress,
      submissionSuccess: submissionSuccess ?? this.submissionSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [phoneNumber, password, submissionInProgress, submissionSuccess, errorMessage];
}
