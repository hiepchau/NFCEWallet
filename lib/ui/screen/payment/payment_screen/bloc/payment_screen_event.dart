part of 'payment_screen_bloc.dart';

abstract class PaymentScreenEvent {
  const PaymentScreenEvent();
}

class InitPaymentScreenEvent extends PaymentScreenEvent{
}

class ChangeThemeEvent extends PaymentScreenEvent {
  final int themeIndex;

  const ChangeThemeEvent(this.themeIndex);
}

class ChangeMessageEvent extends PaymentScreenEvent {
  final String message;

  const ChangeMessageEvent(this.message);
}

class ChangeAmountEvent extends PaymentScreenEvent {
  final String amount;

  const ChangeAmountEvent(this.amount);
}
