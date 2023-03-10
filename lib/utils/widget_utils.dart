import 'package:nfc_e_wallet/utils/list_utils.dart';
import 'package:flutter/material.dart';

class WidgetUtils {
  static Widget toIconDisplay(Object object, double? size) {
    Widget result;
    if (object is IconData) {
      result = Icon(object);
    } else if (object is String) {
      result = Text(object);
    } else if (object is AssetImage) {
      result = Image(image: object);
    } else if (object is ImageProvider) {
      result = Image(image: object);
    } else if (object is Widget) {
      result = object;
    } else {
      throw Exception('Invalid object type');
    }
    if (size == null || size <= 0) {
      return result;
    }
    return SizedBox(width: size, height: size, child: result);
  }

  static List<Widget> stackEvenlyWidthDivide(
      double maxWidth, double perWidgetWidth, List<Widget> list) {
    final widgets = <Widget>[];
    double divideWidth =
        (maxWidth - perWidgetWidth * list.length) / (list.length + 1);

    widgets.add(SizedBox(width: divideWidth));
    var left = divideWidth;

    for (var i = 0; i < list.length; i++) {
      widgets.add(Positioned(left: left, child: list[i]));
      left += perWidgetWidth;
      widgets.add(Positioned(left: left, child: SizedBox(width: divideWidth)));
      left += divideWidth;
    }

    return widgets;
  }

  static List<List<Widget>> stackEvenlyWidthDivideWrap(double maxWidth,
      double perWidgetWidth, int itemPerRow, List<Widget> list) {
    List<List<Widget>> rows = ListUtils.splitList(list, itemPerRow);
    List<List<Widget>> result = [];
    for (var i = 0; i < rows.length; i++) {
      result.add(stackEvenlyWidthDivide(maxWidth, perWidgetWidth, rows[i]));
    }
    return result;
  }

  static List<Widget> rowEvenlyWidthDivide(
      double maxWidth, double perWidgetWidth, List<Widget> list) {
    final widgets = <Widget>[];
    double divideWidth =
        (maxWidth - perWidgetWidth * list.length) / (list.length + 1);

    widgets.add(SizedBox(width: divideWidth));

    for (var i = 0; i < list.length; i++) {
      widgets.add(list[i]);
      widgets.add(SizedBox(width: divideWidth));
    }

    return widgets;
  }

  static List<List<Widget>> rowEvenlyWidthDivideWrap(double maxWidth,
      double perWidgetWidth, int itemPerRow, List<Widget> list) {
    List<List<Widget>> rows = ListUtils.splitList(list, itemPerRow);
    List<List<Widget>> result = [];
    for (var i = 0; i < rows.length; i++) {
      result.add(rowEvenlyWidthDivide(maxWidth, perWidgetWidth, rows[i]));
    }
    return result;
  }
}
