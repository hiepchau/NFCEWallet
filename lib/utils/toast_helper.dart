import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastHelper {
  static showToast(String msg, {ToastStatus status = ToastStatus.normal}) {
    Color bgColor;
    switch (status) {
      case ToastStatus.success:
        bgColor = Colors.green;
        break;
      case ToastStatus.failure:
        bgColor = Colors.red;
        break;
      default:
        bgColor = Colors.grey;
        break;
    }

    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor,
      textColor: Colors.white,
    );
  }
}

enum ToastStatus { normal, success, failure }
