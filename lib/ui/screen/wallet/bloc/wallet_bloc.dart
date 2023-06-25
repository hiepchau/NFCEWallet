import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:nfc_e_wallet/data/preferences.dart';
import 'package:nfc_e_wallet/data/repositories/wallet_repo.dart';
import 'package:nfc_e_wallet/main.dart';

import '../../../../data/model/wallet.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletState()) {
    on<InitWalletEvent>((event, emit) async {
      var walletRepo = GetIt.instance.get<WalletRepo>();
      final user = jsonDecode(prefs.getString(Preferences.user)!);
      List<Wallet> listWallet = [];
      for(var wallet in user["wallets"]){
        listWallet.add(Wallet.fromJson(wallet));
      }
      emit(WalletInitialState().copyWith(listWallet: listWallet));
     });
    on<CreateWalletEvent>(((event, emit) async {
      var walletRepo = GetIt.instance.get<WalletRepo>();
      try {
        final wallet = await walletRepo.createWallet(
            event.name, event.type, event.cardNumber);
        listWallet.add(wallet!);
        emit(WalletCreatedState(wallet));
      } catch (exception) {
        if (exception is DioException) {
          print(exception.response!.data);
        }
        print("Create wallet failed");
      }
    }));
  }
}
