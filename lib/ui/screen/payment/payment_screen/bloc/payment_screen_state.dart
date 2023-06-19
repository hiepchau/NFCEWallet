part of 'payment_screen_bloc.dart';

class PaymentScreenState {
  final int themeIndex;
  final String message;
  final String amount;
  const PaymentScreenState(
      {this.themeIndex = 0, this.message = "", this.amount = ""});
  PaymentScreenState copyWith(
      {int? themeIndex, String? message, String? amount}) {
    return PaymentScreenState(
        themeIndex: themeIndex ?? this.themeIndex,
        message: message ?? this.message,
        amount: amount ?? this.amount);
  }
}

class PaymentScreenInitialState extends PaymentScreenState {
  PaymentScreenInitialState(int? themeIndex, String? message, String? amount);
}

class ThemeState extends PaymentScreenState {

  const ThemeState(themeIndex);
}

class MessageState extends PaymentScreenState {
  const MessageState(message);
}

class AmountState extends PaymentScreenState {
  const AmountState(amount);
}
