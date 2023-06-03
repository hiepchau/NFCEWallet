// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'package:expandable_page_view/expandable_page_view.dart';

import '../../../utils/bubble_indicator_painter.dart';
import '../../../utils/snackbar.dart';
import '../../style/color.dart';
import 'qr_generate.dart';
import 'qr_scanner.dart';


class QRScreen extends StatefulWidget {
  final String id;
  const QRScreen(
      this.id, {
        Key? key,
      }) : super(key: key);

  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  late PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  @override
  void initState() {
    if (widget.id == 'QRCODE') {
      _pageController = PageController(initialPage: 0);
      right = Colors.white;
      left = Colors.black;
    } else if (widget.id == "QRSCANNER") {
      _pageController = PageController(initialPage: 1);
      right = Colors.black;
      left = Colors.white;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                leading: BackButton(color: onPrimary),
                backgroundColor: primary,
                title: Text(
                  'QR',
                  style: TextStyle(color: onPrimary),
                )),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,
                          child: ExpandablePageView(
                            controller: _pageController,
                            physics: const ClampingScrollPhysics(),
                            onPageChanged: (int i) {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (i == 0) {
                                setState(() {
                                  right = Colors.white;
                                  left = Colors.black;
                                });
                              } else if (i == 1) {
                                setState(() {
                                  right = Colors.black;
                                  left = Colors.white;
                                });
                              }
                            },
                            children: <Widget>[
                              const SizedBox(
                                child: GenerateQRScreen(),
                              ),
                              SizedBox(
                                child: QRScannerScreen(),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 25.0),
                            child: _buildMenuBar(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: const BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: BubbleIndicatorPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: _onQRCodeButtonPress,
                child: Text(
                  'Mã thanh toán',
                  style: TextStyle(
                      color: left, fontSize: 16.0, fontFamily: 'SVN-Gotham'),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: _onQRScannerButtonPress,
                child: Text(
                  'Quét mã QR',
                  style: TextStyle(
                      color: right, fontSize: 16.0, fontFamily: 'SVN-Gotham'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRCodeButtonPress() {
    _pageController.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onQRScannerButtonPress() {
    kIsWeb
        ? CustomSnackBar(
        context, const Text("Không thể sử dụng QR Scanner khi ở bản web!"))
        : _pageController.animateToPage(1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.decelerate);
  }
}
