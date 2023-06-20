part of 'payment_screen_bloc.dart';

class PaymentScreenState {
  final int themeIndex;
  final String message;
  final String amount;
  final String phoneNumber;
  const PaymentScreenState({
    this.themeIndex = 0,
    this.message = "",
    this.amount = "",
    this.phoneNumber="",
  });
  PaymentScreenState copyWith({
    int? themeIndex,
    String? message,
    String? amount,
    String? phoneNumber
  }) {
    return PaymentScreenState(
      themeIndex: themeIndex ?? this.themeIndex,
      message: message ?? this.message,
      amount: amount ?? this.amount,
      phoneNumber: phoneNumber ?? this.phoneNumber
    );
  }
}

class PaymentScreenInitialState extends PaymentScreenState {}

class ThemeState extends PaymentScreenState {}

class MessageState extends PaymentScreenState {}

class AmountState extends PaymentScreenState {}

class PhoneNumberState extends PaymentScreenState {}
