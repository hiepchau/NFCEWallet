import 'package:nfc_manager/nfc_manager.dart';

class NFCManager{
  static final NfcManager nfcInstance = NfcManager.instance;
  Future<void> getNFCAvailable() async {
    bool isAvailable = await nfcInstance.isAvailable();
    print(isAvailable);
  }
  
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
    final ndefTag = Ndef.from(tag);
    if (ndefTag == null) throw Exception('No NDEF tag');
    final data = await ndefTag.read();
    print(data);
  }

}