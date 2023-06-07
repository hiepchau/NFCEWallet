import 'payment_screen_event.dart';

abstract class PaymentState {}

class PaymentInitialState extends PaymentState {
  final ThemeIndex themeIndex;
  final String value;
  final String message;

  PaymentInitialState(
      {this.themeIndex = ThemeIndex.theme0, this.value = "", this.message = ""});
}

class PaymentUpdatedState extends PaymentState {
  final ThemeIndex themeIndex;
  final String value;
  final String message;

  PaymentUpdatedState(
      {this.themeIndex = ThemeIndex.theme0, this.value = "", this.message = ""});
}

class PaymentProceededState extends PaymentState {}