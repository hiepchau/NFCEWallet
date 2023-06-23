import 'package:nfc_manager/nfc_manager.dart';

class NFCManager{
  static final NfcManager nfcInstance = NfcManager.instance;
  void startNFCSession() async {
    await nfcInstance.startSession(
      onDiscovered: (tag) async{
        ReceivePaymentRequest(tag);
      },
      onError: (dynamic error) async{
        print(error.message);
      },
    );
  }

  void ReceivePaymentRequest(NfcTag tag) async{
    print(tag.data);
  }

}