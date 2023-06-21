import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nfc_e_wallet/data/model/transaction.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryState()) {
    on<HistoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
