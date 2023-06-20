import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:nfc_e_wallet/data/preferences.dart';
import 'package:nfc_e_wallet/data/repositories/transaction_repo.dart';
import 'package:nfc_e_wallet/data/repositories/user_repo.dart';
import 'package:nfc_e_wallet/main.dart';
import 'package:nfc_e_wallet/utils/notification_manager.dart';

part 'payment_confirm_event.dart';
part 'payment_confirm_state.dart';

class PaymentConfirmBloc
    extends Bloc<PaymentConfirmEvent, PaymentConfirmState> {
  PaymentConfirmBloc() : super(PaymentConfirmState()) {
    on<InitializePaymentEvent>((event, emit) async {
      final userRepo = GetIt.instance.get<UserRepo>();

      try{
      Map<String, dynamic> receiver = jsonDecode((await userRepo.getUserByPhoneNumber(event.phoneNumber))!);
      emit(state.copyWith(
        amount: event.amount,
        receiverName: receiver["full_name"],
        receiverWalletId: receiver["wallets"][0]["id"].toString(),
        phoneNumber: event.phoneNumber,
        message: event.message,
      ));
      }catch(exception) {
        if (exception is DioException) {
          print(exception.response!.data);
        }
        print("Get user data failed due to exception: $exception");
      }
    });
    on<UpdateAmountEvent>((event, emit) {
      emit(state.copyWith(
        amount: event.newAmount,
      ));
    });
    on<SendPaymentEvent>((event, emit) async {
      final transactionRepo = GetIt.instance.get<TransactionRepo>();
      final Map<String, dynamic> user = jsonDecode(prefs.getString(Preferences.user)!);
      try{
        String amount=state.amount;
        if(amount.contains(RegExp(r'(\.|[đ])'))){
          amount = amount.replaceAll(RegExp(r'(\.|[đ])'), '');
        }

        String? otp = await transactionRepo.createTransferTransaction(user["wallets"][0]["id"].toString(), state.receiverWalletId, amount, state.message!);
        if (otp != null) {
          print("Create transfer transaction success. OTP: $otp");

          emit(state.copyWith(isSuccess: true));

          await NotificationManager.showNotification(
            id: 0,
            title: 'OTP Received',
            body: 'Your OTP is $otp',
          );
        }
      }catch(exception) {
        if (exception is DioException) {
          print(exception.response!.data);
        }
        print("Get user data failed due to exception: $exception");
      }
    });
  }
}
