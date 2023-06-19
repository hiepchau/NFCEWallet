abstract class PaymentEvent {
  const PaymentEvent();
}

class ChangeThemeEvent extends PaymentEvent {
  final int themeIndex;

  const ChangeThemeEvent(this.themeIndex);
}

class ChangeMessageEvent extends PaymentEvent {
  final String message;

  const ChangeMessageEvent(this.message);
}

class ChangeAmountEvent extends PaymentEvent {
  final String amount;

  const ChangeAmountEvent(this.amount);
}

