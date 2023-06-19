part of 'wallet_bloc.dart';

abstract class WalletState {}

class WalletInitialState extends WalletState {
  final List<Wallet>? listWallet = [];
}

class WalletReadyState extends WalletState {
  final List<Wallet>? listWallet;
  WalletReadyState(this.listWallet);
}

class WalletCreatedState extends WalletState {
  final Wallet? wallet;
  WalletCreatedState(this.wallet);
}

class WalletSyncingState extends WalletState {}
