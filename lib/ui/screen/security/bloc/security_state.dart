part of 'security_bloc.dart';

class SecurityState {
  final bool isAuthByFingerprint;
  final bool isNFCEnable;
  SecurityState({
    this.isAuthByFingerprint = false,
    this.isNFCEnable = false,
  });
  SecurityState copyWith({
    bool? isAuthByFingerprint,
    bool? isNFCEnable,
  }) {
    return SecurityState(
      isAuthByFingerprint: isAuthByFingerprint ?? this.isAuthByFingerprint,
      isNFCEnable: isNFCEnable ?? this.isNFCEnable,
    );
  }
}
