import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nfc_host_card_emulation/nfc_host_card_emulation.dart';

part 'nfc_event.dart';
part 'nfc_state.dart';

class NfcBloc extends Bloc<NfcEvent, NfcState> {
  NfcBloc() : super(NfcInitial()) {
    on<InitNFCEvent>((event, emit) async {
      await NfcHce.addApduResponse(event.port, event.data);
    });
  }
}
