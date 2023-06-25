import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nfc_e_wallet/main.dart';

part 'security_event.dart';
part 'security_state.dart';

class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  SecurityBloc(bool AuthByFingerprint, bool NFCEnable) : super(SecurityState(isAuthByFingerprint: AuthByFingerprint, isNFCEnable: NFCEnable)) {
    on<SwitchFingerprintEvent>((event, emit) {
      prefs.setBool("AuthByFingerprint", event.isAuthByFingerprint);
      isAuthByFingerprint = event.isAuthByFingerprint;
      emit(state.copyWith(isAuthByFingerprint: event.isAuthByFingerprint));
    });
    on<SwitchNFCEvent>((event, emit) {
      prefs.setBool("NFC", event.isNFCEnable);
      isNFCEnable = event.isNFCEnable;
      emit(state.copyWith(isNFCEnable: event.isNFCEnable));
    });
  }
}
