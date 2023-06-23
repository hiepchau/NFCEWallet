import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'deposit_event.dart';
part 'deposit_state.dart';

class DepositBloc extends Bloc<DepositEvent, DepositState> {
  DepositBloc() : super(const DepositState()) {
    on<ChangeAmountEvent>((event, emit) {
      emit(state.copyWith(amount: event.amount));
    });
    on<SubmitEvent>((event, emit) {
      
    });
  }
}
