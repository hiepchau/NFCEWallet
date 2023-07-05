part of 'nfc_bloc.dart';

abstract class NfcState extends Equatable {
  const NfcState();
  
  @override
  List<Object> get props => [];
}

class NfcInitial extends NfcState {}
