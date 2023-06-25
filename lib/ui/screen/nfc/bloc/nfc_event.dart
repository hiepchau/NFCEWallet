part of 'nfc_bloc.dart';

abstract class NfcEvent  {}

class InitNFCEvent extends NfcEvent{
  final int port;
  final List<int> data;
  InitNFCEvent(this.port, this.data);
}
