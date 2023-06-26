import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nfc_e_wallet/data/model/transaction.dart';
import 'package:nfc_e_wallet/data/model/user.dart';
import 'package:nfc_e_wallet/data/preferences.dart';
import 'package:nfc_e_wallet/data/repositories/wallet_repo.dart';
import 'package:nfc_e_wallet/l10n/messages_vi.dart';
import 'package:nfc_e_wallet/main.dart';

part 'payment_success_event.dart';
part 'payment_success_state.dart';

class PaymentSuccessBloc
    extends Bloc<PaymentSuccessEvent, PaymentSuccessState> {
  PaymentSuccessBloc() : super(PaymentSuccessState()) {
    on<InitPaymentSuccessEvent>((event, emit) async {
      final walletRepo = GetIt.instance.get<WalletRepo>();
      final User user =
          User.fromJson(jsonDecode(prefs.getString(Preferences.user)!));
      final transaction = event.transacion;
      if (transaction.type == "TRANSFER") {
        try {
          final receiver = await walletRepo
              .getUserByWallet(transaction.to_User)
              .then((value) => User.fromJson(value!));
          emit(state.copyWith(
            type: transaction.type,
            recipient: receiver.full_name,
            message: transaction.message,
            paymentTime: formatDate(transaction.time!),
            phoneNumber: receiver.phone_number,
            sender: user.full_name,
            amount: transaction.amount.toString(),
          ));
        } catch (exception) {
          if (exception is DioException) {
            print(exception.response!.data);
          }
          print("Get user data failed due to exception: $exception");
        }
      } else if (transaction.type == "RECEIVE") {
        try {
          final sender = await walletRepo
              .getUserByWallet(transaction.from_User)
              .then((value) => User.fromJson(value!));
          emit(state.copyWith(
              type: transaction.type,
              recipient: user.full_name,
              message: transaction.message,
              paymentTime: formatDate(transaction.time!),
              phoneNumber: sender.phone_number,
              sender: sender.phone_number,
              amount: transaction.amount.toString()));
        } catch (exception) {
          if (exception is DioException) {
            print(exception.response!.data);
          }
          print("Get user data failed due to exception: $exception");
        }
      } else if (transaction.type == "DEPOSIT") {
        try {
          emit(state.copyWith(
              type: transaction.type,
              recipient: user.full_name,
              message: transaction.message,
              paymentTime: formatDate(transaction.time!),
              phoneNumber: user.phone_number,
              sender: transaction.from_User,
              amount: transaction.amount.toString()));
        } catch (exception) {
          if (exception is DioException) {
            print(exception.response!.data);
          }
          print("Get user data failed due to exception: $exception");
        }
      } else if (transaction.type == "WITHDRAW") {
        try {
          emit(state.copyWith(
              type: transaction.type,
              recipient: transaction.to_User,
              message: transaction.message,
              paymentTime: formatDate(transaction.time!),
              phoneNumber: user.phone_number,
              sender: user.phone_number,
              amount: transaction.amount.toString()));
        } catch (exception) {
          if (exception is DioException) {
            print(exception.response!.data);
          }
          print("Get user data failed due to exception: $exception");
        }
      }
    });
  }

  String formatDate(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('HH:mm dd/MM/yyyy');
    var outputDate =
        outputFormat.format(inputDate.add(const Duration(hours: 7)));
    return outputDate;
  }
}
