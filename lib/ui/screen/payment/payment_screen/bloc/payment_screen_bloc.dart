import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_screen_event.dart';
part 'payment_screen_state.dart';

class PaymentScreenBloc extends Bloc<PaymentScreenEvent, PaymentScreenState> {
  PaymentScreenBloc() : super(const PaymentScreenState()) {
    on<ChangeThemeEvent>((event, emit) {
      emit(state.copyWith(themeIndex: event.themeIndex));
    });
    on<ChangeMessageEvent>((event, emit) {
      emit(state.copyWith(message: event.message));
    });
    on<ChangeAmountEvent>((event, emit) {
      emit(state.copyWith(amount: event.amount));
    });
  }
}
