part of 'security_bloc.dart';

abstract class SecurityEvent {}

class InitSecurityEvent extends SecurityEvent{}

class SwitchNFCEvent extends SecurityEvent{
  final bool isNFCEnable;
  SwitchNFCEvent(this.isNFCEnable);
}

class SwitchFingerprintEvent extends SecurityEvent{
  final bool isAuthByFingerprint;
  SwitchFingerprintEvent(this.isAuthByFingerprint);
}
