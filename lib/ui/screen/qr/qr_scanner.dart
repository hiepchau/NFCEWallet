import 'dart:async';
import 'package:barcode_scan2/barcode_scan2.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_navigator.dart';
import '../payment/payment_screen.dart';

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScannerScreen> {
  String _scanResult = "";
  bool _isFlashOn = false;

  Future _scanQR(BuildContext context) async {
    try {
      String qrResult = (await BarcodeScanner.scan(
          options: ScanOptions(autoEnableFlash: _isFlashOn)))
          .rawContent;
      setState(() {
        _scanResult = qrResult;
        AppNav.pushWidget(context, PaymentScreen());
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          _scanResult = "Camera permission was denied";
        });
      } else {
        setState(() {
          _scanResult = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        _scanResult = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        _scanResult = "Unknown Error $ex";
      });
    }
  }

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextButton(
            child: Text("Scan QR code"),
            onPressed: () {
              _scanQR(context);
            },
          ),
          Text(_scanResult),
        ],
      ),
    );
  }
}
