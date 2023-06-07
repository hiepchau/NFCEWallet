enum ThemeIndex { theme0, theme1 }

abstract class PaymentEvent {}

class SetThemeEvent extends PaymentEvent {
  final ThemeIndex themeIndex;

  SetThemeEvent(this.themeIndex);
}

class UpdateValueEvent extends PaymentEvent {
  final String value;

  UpdateValueEvent(this.value);
}

class UpdateMessageEvent extends PaymentEvent {
  final String message;

  UpdateMessageEvent(this.message);
}

class ProceedPaymentEvent extends PaymentEvent {}

