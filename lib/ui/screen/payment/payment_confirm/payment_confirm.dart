import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nfc_e_wallet/data/preferences.dart';
import 'package:nfc_e_wallet/main.dart';
import 'package:nfc_e_wallet/ui/screen/otp/otp_screen.dart';
import 'package:nfc_e_wallet/ui/screen/payment/payment_confirm/bloc/payment_confirm_bloc.dart';

import '../../../style/color.dart';
import '../../../widgets/dashed_line.dart';
import '../payment_success/payment_success_screen.dart';

class PaymentConfirm extends StatelessWidget {
  final String amount;
  final String receiverPhoneNumber;
  final String? message;
  final String type;

  const PaymentConfirm({
    Key? key,
    required this.amount,
    required this.type,
    required this.receiverPhoneNumber,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentConfirmBloc()
        ..add(InitializePaymentEvent(
            type: type,
            amount: amount,
            phoneNumber: receiverPhoneNumber,
            message: message)),
      child: Scaffold(
        body: _paymentConfirmPage(
          type: type,
        ),
      ),
    );
  }
}

class _paymentConfirmPage extends StatelessWidget {
  final String type;
  const _paymentConfirmPage({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> user =
        jsonDecode(prefs.getString(Preferences.user)!);
    String title = "";
    List<List<String>> textLine = List.empty(growable: true);

    return BlocListener<PaymentConfirmBloc, PaymentConfirmState>(
      listener: (context, state) {
        if (state.isSuccess == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OTPScreen(phoneNumber: user["phone_number"]),
            ),
          );
        }
      },
      child: BlocBuilder<PaymentConfirmBloc, PaymentConfirmState>(
          builder: (context, state) {
        // Placeholder values to be replaced by actual data from the state
        String amount = state.amount;
        String phoneNumber = state.phoneNumber;
        String receiverName = state.receiverName;
        String? message = state.message;

        if (type == "DEPOSIT") {
          title = "Nạp tiền vào ví";
          textLine = [
            ['Người nhận', user["full_name"]],
            ['Số điện thoại', phoneNumber],
            ['Phí giao dịch', 'Miễn phí'],
          ];
        } else if (type == "WITHDRAW") {
          title = "Rút tiền";
          textLine = [
            ['Người nhận', user["full_name"]],
            ['Số điện thoại', phoneNumber],
            ['Phí giao dịch', 'Miễn phí'],
          ];
        } else if (type == "TRANSFER") {
          title = "Chuyển tiền đến $receiverName";
          textLine = [
            ['Người nhận', receiverName],
            ['Số điện thoại', phoneNumber],
            ['Lời nhắn', message ?? ""],
            ['Phí giao dịch', 'Miễn phí'],
          ];
        }


        return Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text('Xác nhận giao dịch',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.close,
                                  size: 20.w,
                                ))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2)),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                    Icon(
                                      Icons.currency_exchange_rounded,
                                      size: 30.w,
                                      color: green,
                                    ),
                                    Text(
                                      amount,
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      title,
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    DashedLine(),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                  ] +
                                  buildLines(textLine, context),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2)),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(FontAwesomeIcons.wallet),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Nguồn tiền thanh toán',
                                            style: TextStyle(fontSize: 15.sp)),
                                        Text(
                                            'Số dư: ${user["wallets"][0]["balance"]}đ',
                                            style: TextStyle(fontSize: 12.sp))
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                  'Thay đổi',
                                  style: TextStyle(
                                      fontSize: 12.sp, color: primary),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: green,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextButton(
                          onPressed: () {
                            context
                                .read<PaymentConfirmBloc>()
                                .add(SendPaymentEvent(type: type));
                          },
                          child: Text(
                            'Xác nhận giao dịch',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shield,
                            color: green,
                          ),
                          Text('Bảo mật tuyệt đối theo chuẩn cao nhất',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w300,
                              ))
                        ],
                      )
                    ],
                  )),
            ),
          ],
        );
      }),
    );
  }

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
                  fontSize: 11.sp,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                line[1],
                style: TextStyle(
                  fontSize: 11.sp,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
