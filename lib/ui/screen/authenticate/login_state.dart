// login_state.dart
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool submissionInProgress;
  final bool submissionSuccess;
  final String errorMessage;
  final bool isSigningInWithPhoneNumber; // Newly added

  const LoginState({
    this.email = '',
    this.password = '',
    this.submissionInProgress = false,
    this.submissionSuccess = false,
    this.errorMessage = '',
    this.isSigningInWithPhoneNumber = false, // Default to email/password sign in
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? submissionInProgress,
    bool? submissionSuccess,
    String? errorMessage,
    bool? isSigningInWithPhoneNumber, // Newly added
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      submissionInProgress: submissionInProgress ?? this.submissionInProgress,
      submissionSuccess: submissionSuccess ?? this.submissionSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      isSigningInWithPhoneNumber: isSigningInWithPhoneNumber ?? this.isSigningInWithPhoneNumber, // Newly added
    );
  }

  @override
  List<Object> get props => [email, password, submissionInProgress, submissionSuccess, errorMessage, isSigningInWithPhoneNumber]; // Updated
}
