import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:nfc_e_wallet/data/model/user.dart';
import 'package:nfc_e_wallet/data/preferences.dart';
import 'package:nfc_e_wallet/data/repositories/wallet_repo.dart';
import 'package:nfc_e_wallet/l10n/messages_vi.dart';
import 'package:nfc_e_wallet/main.dart';

part 'payment_success_event.dart';
part 'payment_success_state.dart';

class PaymentSuccessBloc extends Bloc<PaymentSuccessEvent, PaymentSuccessState> {
  PaymentSuccessBloc() : super(PaymentSuccessState()) {
    on<InitPaymentSuccessEvent>((event, emit) async {
      final walletRepo = GetIt.instance.get<WalletRepo>();
      final User user = User.fromJson(jsonDecode(prefs.getString(Preferences.user)!));
      final transaction = event.transacion;
      if (transaction["type"] == "TRANSFER") {
        try {
          final receiver = await walletRepo.getUserByWallet(transaction["to_User"]).then((value) => User.fromJson(value!));
          emit(state.copyWith(
            recipient: receiver.full_name,
            message: transaction["message"],
            paymentTime: transaction["time"],
            phoneNumber: receiver.phone_number,
            sender: user.full_name,
            amount: transaction["amount"].toString(),
          ));
        } catch (exception) {
          if(exception is DioException){
            print(exception.response!.data);
          }
          print("Get user data failed due to exception: $exception");
        }
      } else if (transaction["type"] == "RECEIVE") {
        try {
          final sender =
              await walletRepo.getUserByWallet(transaction["from_User"]).then((value)=> User.fromJson(value!));
          emit(state.copyWith(
              recipient: user.full_name,
              message: transaction["message"],
              paymentTime: transaction["time"],
              phoneNumber: sender.phone_number,
              sender: sender.phone_number,
              amount: transaction["amount"].toString()));
        } catch (exception) {
          if (exception is DioException) {
            print(exception.response!.data);
          }
          print("Get user data failed due to exception: $exception");
        }
      }
    });
  }
}
