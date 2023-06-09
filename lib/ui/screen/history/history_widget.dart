import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../style/color.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../payment/payment_success/payment_success_screen.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.balance,
    required this.amount,
  });
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String time;
  final String balance;
  final String amount;
  static bool isObscure = true;
  @override
  _HistoryWidget createState() => _HistoryWidget();
}

class _HistoryWidget extends State<HistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PaymentSuccessScreen(sender: '',
        recipient: '',
        phoneNumber: '',
        message: '',
        paymentTime: '',)));},
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              color: grey.withOpacity(0.01),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width > 900
                          ? 50
                          : MediaQuery.of(context).size.width > 350
                          ? 30
                          : 25,
                      height: 50,
                      child: Center(
                        child: Icon(
                          widget.icon,
                          color: widget.iconColor,
                          size: MediaQuery.of(context).size.width > 900
                              ? 55
                              : MediaQuery.of(context).size.width > 350
                              ? 40
                              : 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width > 900
                          ? 50
                          : MediaQuery.of(context).size.width > 350
                          ? 30
                          : 25,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width >
                                    900
                                    ? 18
                                    : MediaQuery.of(context).size.width > 350
                                    ? 16
                                    : 13,
                                fontFamily: 'SVN-Gotham',
                                fontWeight: FontWeight.bold,
                                color: primary),
                          ),
                          Text(
                            DateFormat("HH:mm dd/MM/yyyy")
                                .format(DateTime.parse(widget.time)),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Color.fromARGB(125, 0, 0, 0),
                                fontSize: MediaQuery.of(context).size.width >
                                    900
                                    ? 13
                                    : MediaQuery.of(context).size.width > 350
                                    ? 12
                                    : 12,
                                fontFamily: 'SVN-Gotham'),
                          ),
                          Text(
                            HistoryWidget.isObscure
                                ? "Số dư ví: ******"
                                : "Số dư ví: " + widget.balance,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Color.fromARGB(125, 0, 0, 0),
                                fontSize: MediaQuery.of(context).size.width >
                                    900
                                    ? 13
                                    : MediaQuery.of(context).size.width > 350
                                    ? 12
                                    : 12,
                                fontFamily: 'SVN-Gotham'),
                          )
                        ])
                  ],
                ),
                Flexible(
                    fit: FlexFit.tight,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.amount,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width >
                                    900
                                    ? 18
                                    : MediaQuery.of(context).size.width > 350
                                    ? 15
                                    : 13,
                                fontFamily: 'SVN-Gotham',
                                color: primary),
                          ),
                          Text(
                            "Thành công",
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width >
                                    900
                                    ? 18
                                    : MediaQuery.of(context).size.width > 350
                                    ? 15
                                    : 13,
                                color: Colors.green,
                                fontFamily: 'SVN-Gotham'),
                          )
                        ])),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: grey,
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
