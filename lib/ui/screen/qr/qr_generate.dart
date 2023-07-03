import 'dart:math';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:nfc_e_wallet/main.dart';

import '../../style/color.dart';
import '../../style/constants.dart';

class GenerateQRScreen extends StatefulWidget {
  const GenerateQRScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GenerateQRPageState createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRScreen> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
  TextEditingController controller = TextEditingController();
  String data = user.phone_number;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width < 900
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width / 2,
                maxWidth: MediaQuery.of(context).size.width >= 900
                    ? MediaQuery.of(context).size.width / 2
                    : MediaQuery.of(context).size.width),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2))
                      ]),
                  child: Column(children: [
                    Text(
                      "Đưa mã này cho thu ngân để thanh toán",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height <= 600
                              ? 13
                              : 15),
                    ),
                    SizedBox(
                      height:
                      MediaQuery.of(context).size.height <= 600 ? 10 : 20,
                    ),
                    BarcodeWidget(
                      barcode: Barcode.qrCode(),
                      data: data,
                      width: 250,
                      height:
                      MediaQuery.of(context).size.height <= 600 ? 150 : 250,
                    ),
                    SizedBox(
                      height:
                      MediaQuery.of(context).size.height <= 600 ? 10 : 20,
                    ),
                    BarcodeWidget(
                      barcode: Barcode.code128(),
                      data: data,
                      width: 300,
                      height: 50,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Tự động cập nhật sau ",
                          style: wBlackTextStyle,
                        ),
                        CountdownTimer(
                          endTime: endTime,
                          onEnd: () {
                            setState(() {
                              endTime = DateTime.now().millisecondsSinceEpoch +
                                  1000 * 60;
                              data = Random().nextInt(100000).toString();
                            });
                          },
                          textStyle: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                  ]),
                ),
                SizedBox(
                    height:
                    MediaQuery.of(context).size.height <= 600 ? 10 : 20),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: white,
                      boxShadow: [
                        BoxShadow(
                            color: grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2)),
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 30,
                            height: 30,
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                  "assets/images/icons/vietcombankIcon.png"),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width <= 350
                                ? 10
                                : 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Nguồn tiền thanh toán",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                      MediaQuery.of(context).size.height <=
                                          600
                                          ? 13
                                          : 15),
                                ),
                                Text("Số dư: 2.000.000",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .height <=
                                            600
                                            ? 13
                                            : 15)),
                              ],
                            ),
                          ),
                          const Text(
                            "Thay đổi",
                            style: wBlueTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
