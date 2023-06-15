import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:nfc_e_wallet/data/repositories/wallet_repo.dart';

import '../../../../data/model/wallet.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitialState()) {
    on<InitWalletEvent>((event, emit) async {
      var walletRepo = GetIt.instance.get<WalletRepo>();
      try {
        final listWallet = await walletRepo.getListWallet(event.userId);
        if (listWallet == null) {
          emit(WalletReadyState(listWallet));
        }
      } catch (exception) {
        if (exception is DioException) {
          print(exception.response!.data);
        }
        print("Init wallet failed");
      }
    });
    on<CreateWalletEvent>(((event, emit) async {
      var walletRepo = GetIt.instance.get<WalletRepo>();
      try {
        final wallet = await walletRepo.createWallet(
            event.name, event.type, event.cardNumber);
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
