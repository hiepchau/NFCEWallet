part of 'history_bloc.dart';

class HistoryState {
  final List<Transaction> listTransactions;
  HistoryState({this.listTransactions = const []});
  HistoryState copyWith({
    List<Transaction>? listTransactions,
  }) {
    return HistoryState(
      listTransactions: listTransactions ?? this.listTransactions,
    );
  }
}
