abstract class PaymentState {
  const PaymentState();
}

class ThemeState extends PaymentState {
  final int themeIndex;

  const ThemeState(this.themeIndex);
}

class MessageState extends PaymentState {
  final String message;

  const MessageState(this.message);
}

class AmountState extends PaymentState {
  final String amount;

  const AmountState(this.amount);
}

