import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nfc_e_wallet/data/model/transaction.dart';
import 'package:nfc_e_wallet/main.dart';
import 'package:nfc_e_wallet/ui/screen/payment/payment_success/bloc/payment_success_bloc.dart';
import '../../../style/color.dart';
import '../../app_navigator.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final Transaction transaction;

  const PaymentSuccessScreen({Key? key, required this.transaction})
      : super(key: key);

  List<Widget> buildLines(List<List<String>> lines, BuildContext context) {
    return lines.map((line) {
      return IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                line[0],
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: MediaQuery.of(context).size.width > 350 ? 15 : 12,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                line[1],
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 350 ? 15 : 12,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    String title = "";
    String amount = "1";
    List<List<String>> textLine = List.empty(growable: true);
    return BlocProvider(
        create: (context) =>
            PaymentSuccessBloc()..add(InitPaymentSuccessEvent(transaction)),
        child: BlocBuilder<PaymentSuccessBloc, PaymentSuccessState>(
          builder: (context, state) {
            amount = state.amount;
            final type = state.type;
            if (type == "DEPOSIT") {
              title = "Nạp tiền vào ví";
              textLine = [
                ['Từ', state.sender!],
                ['Người nhận', user.full_name],
                ['Số điện thoại', user.phone_number],
                ['Phí giao dịch', 'Miễn phí'],
                ['Thời gian', state.paymentTime],
              ];
            } else if (type == "WITHDRAW") {
              title = "Rút tiền về ví ${state.recipient}";
              textLine = [
                ['Người nhận', user.full_name],
                ['Số điện thoại', user.phone_number],
                ['Phí giao dịch', 'Miễn phí'],
              ];
            } else if (type == "TRANSFER") {
              title = "Chuyển tiền đến ${state.recipient}";
              textLine = [
                ['Người nhận', state.recipient],
                ['SĐT', state.phoneNumber],
                ['Lời nhắn', state.message],
                ['Thời gian', state.paymentTime],
                ['Phí giao dịch', 'Miễn phí'],
              ];
            }
            else if (type == "PAYMENT") {
              title = "Thanh toán đơn hàng ở ${state.recipient}";
              textLine = [
                ['SĐT', state.phoneNumber],
                ['Thời gian', state.paymentTime],
                ['Phí giao dịch', 'Miễn phí'],
              ];
            }
            else if (type == "RECEIVE") {
              title = "Nhận tiền từ ${state.sender}";
              textLine = [
                ['Người gửi', state.sender],
                ['SĐT người gửi', state.phoneNumber],
                ['Thời gian', state.paymentTime],
                ['Lời nhắn', state.message],
                ['Phí giao dịch', 'Miễn phí'],
              ];
            }
            return SafeArea(
                child: Scaffold(
                    body: Stack(children: [
              AspectRatio(
                aspectRatio: 390 / 252,
                child: Container(
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50)))),
              ),
              Column(children: [
                Expanded(
                    flex: 86,
                    child: Container(
                        child: Center(
                      child: Text('Kết quả giao dịch',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          )),
                    ))),
                Expanded(
                    flex: 438,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 15,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 48,
                            ),
                            Text('Giao dịch thành công',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width > 350
                                            ? 20
                                            : 15,
                                    fontWeight: FontWeight.bold)),
                            Text("${formatCurrency(amount)}đ",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width > 350
                                            ? 30
                                            : 18,
                                    fontWeight: FontWeight.bold)),
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.lightGreen.shade200,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25))),
                                child: Padding(
                                  padding:
                                      MediaQuery.of(context).size.width > 350
                                          ? EdgeInsets.all(10)
                                          : EdgeInsets.all(5),
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.green.shade700,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 20, bottom: 20),
                                  child: Column(
                                      children: buildLines(textLine, context)),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Divider(
                                color: grey,
                                thickness: 0.5,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.info_outline),
                                          Padding(
                                            padding: MediaQuery.of(context)
                                                        .size
                                                        .width >
                                                    350
                                                ? EdgeInsets.only(
                                                    bottom: 5.0, left: 5)
                                                : EdgeInsets.only(
                                                    bottom: 0, left: 5),
                                            child: Text(
                                              'Chi tiết giao dịch',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        350
                                                    ? 15
                                                    : 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: MediaQuery.of(context)
                                                        .size
                                                        .width >
                                                    350
                                                ? EdgeInsets.only(bottom: 5.0)
                                                : EdgeInsets.only(
                                                    bottom: 0,
                                                  ),
                                            child: Text(
                                              '221130-1234567',
                                              style: (TextStyle(
                                                color: Colors.black54,
                                                fontSize: MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        350
                                                    ? 15
                                                    : 12,
                                              )),
                                            ),
                                          ),
                                          Icon(Icons.chevron_right_rounded),
                                        ],
                                      ),
                                    ),
                                  ]),
                            )
                          ],
                        ),
                      ),
                    )),
                Expanded(flex: 200, child: Container()),
                Expanded(
                    flex: 76,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 40, right: 40, top: 10, bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          AppNav.popUntil(context, (route) => route.isFirst);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: Center(
                            child: Text('Đóng',
                                style: TextStyle(
                                  color: onPrimary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        ),
                      ),
                    )),
              ]),
            ])));
            // Handle closure
          },
        ));
  }
  String formatCurrency(String amount) {
    if(amount.isEmpty) return "";
    final currencyFormat = NumberFormat("#,##0.##");
    return currencyFormat.format(int.parse(amount));
  }
}
