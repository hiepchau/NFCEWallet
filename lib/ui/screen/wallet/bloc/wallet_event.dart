part of 'wallet_bloc.dart';

abstract class WalletEvent {}

class InitWalletEvent extends WalletEvent {
  InitWalletEvent();
}

class UpdateWalletEvent extends WalletEvent {
  final String userId;
  UpdateWalletEvent(this.userId);
}

class CreateWalletEvent extends WalletEvent {
  final String name;
  final String type;
  final String cardNumber;
  CreateWalletEvent(this.name, this.type, this.cardNumber);
}
