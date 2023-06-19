part of 'wallet_bloc.dart';

class WalletState {
  final List<Wallet>? listWallet;
  WalletState({this.listWallet = const []});
  WalletState copyWith({List<Wallet>? listWallet}){
    return WalletState(listWallet: listWallet ?? this.listWallet);
  }
}

class WalletInitialState extends WalletState {
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
