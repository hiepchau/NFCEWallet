import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nfc_e_wallet/data/model/transaction.dart';
import 'package:nfc_e_wallet/data/model/user.dart';
import 'package:nfc_e_wallet/data/preferences.dart';
import 'package:nfc_e_wallet/data/repositories/transaction_repo.dart';
import 'package:nfc_e_wallet/main.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryState()) {
    on<InitHistoryEvent>((event, emit) async {
      final transactionRepo = GetIt.instance.get<TransactionRepo>();
      final User user =
          User.fromJson(jsonDecode(prefs.getString(Preferences.user)!));
      try {
        List<Transaction> listTransaction = [];
        await transactionRepo.getListTransaction(user.id.toString()).then(
          (value) {
            for (var element in value!) {
              listTransaction.add(Transaction.fromJson(element));
            }
          },
        );
        emit(state.copyWith(listTransactions: listTransaction));
      } catch (exception) {
        if (exception is DioException) {
          print(exception.response!.data);
        }
        print("Get list transactions data failed due to exception: $exception");
      }
    });
  }

}
