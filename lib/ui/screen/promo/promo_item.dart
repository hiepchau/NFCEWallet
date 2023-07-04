import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nfc_e_wallet/ui/style/color.dart';
import 'package:nfc_e_wallet/ui/widgets/dashed_line.dart';

class PromoItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final String description;
  final String price;
  final String actionTitle;

  const PromoItem(
      {Key? key,
        required this.title,
        required this.subTitle,
        required this.description,
        this.price = '',
        required this.actionTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 150 / 180,
      child: GestureDetector(
        onTap: notAvailable,
        child: Container(
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                final height = constraints.maxHeight;

                final decorateHeight = height * 15 / 180;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: 30.h,
                        height: 30.h,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/icons/baeminIcon.png'),
                            fit: BoxFit.cover,
                          ),
                        )),
                    Text(title,
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: primary)),
                    Text(subTitle,
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: primary)),
                    Text(description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        )),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: decorateHeight,
                              width: decorateHeight / 2,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 215, 215, 215),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(100),
                                    bottomRight: Radius.circular(100),
                                  ))),
                          const Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 4, right: 4),
                                child: DashedLine(),
                              )),
                          Container(
                              height: decorateHeight,
                              width: decorateHeight / 2,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 215, 215, 215),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(100),
                                    bottomLeft: Radius.circular(100),
                                  ))),
                        ]),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.coins,
                                    size: 20.h,
                                    color: Colors.amber,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(price,
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(right: 10, bottom: 5),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(actionTitle,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        color: primary))),
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            )),
      ),
    );
  }
    void notAvailable(){
    SmartDialog.show(builder: (context) {
          return Container(
            height: 100,
            width: 250,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: const Text(
                'Chức năng hiện tại đang phát triển. Xin thông cảm!',
                style: TextStyle(color: Colors.white)),
          );
        });
  }
}
