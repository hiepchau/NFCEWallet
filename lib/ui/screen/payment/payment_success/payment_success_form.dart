import 'package:flutter/material.dart';

import 'payment_success_sreen_state.dart';

class PaymentSuccessForm extends StatelessWidget {
  final PaymentSuccessLoadedState state;

  PaymentSuccessForm({required this.state});

  List<Widget> buildLines(List<List<String>> lines, BuildContext context) {
    List<Widget> widgets = [];
    for (var line in lines) {
      widgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(line[0]),
          Text(line[1]),
        ],
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 48,
        ),
        Text(
          'Giao dịch thành công',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '500.000đ',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.lightGreen.shade200,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Tiền đã được chuyển đến người nhận',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 20,
                bottom: 20,
              ),
              child: Column(
                children: buildLines(
                  [
                    ['Người gửi', state.sender],
                    ['Người nhận', state.recipient],
                    ['SĐT', state.phoneNumber],
                    ['Lời nhắn', state.message],
                    ['Thời gian thanh toán', state.paymentTime],
                  ],
                  context,
                ),
              ),
            ),
          ),
        ),
        // ... the rest of your widgets
      ],
    );
  }
}
