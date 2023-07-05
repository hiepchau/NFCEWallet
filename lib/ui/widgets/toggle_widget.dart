import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

import '../style/color.dart';


class ToggleWidget extends StatefulWidget {
  final ImageProvider icon;
  final String title;
  final String subtitle;
  final Color subtitleColor;
  final Color color;
  final Function(int?)? onChanged;
  final int groupValue;
  final int value;

  const ToggleWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onChanged,
    required this.value,
    required this.groupValue,
    this.color = white,
    this.subtitleColor = black,
  }) : super(key: key);

  @override
  _ToggleWidget createState() => _ToggleWidget();
}

class _ToggleWidget extends State<ToggleWidget> {
  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      controlAffinity: ListTileControlAffinity.trailing,
      value: widget.value,
      groupValue: widget.groupValue,
      onChanged: widget.onChanged,
      title: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.color,
          boxShadow: [
            BoxShadow(
              color: grey.withOpacity(0.01),
              spreadRadius: 5,
              blurRadius: 10,
              // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width > 350 ? 40 : 20,
                      height: MediaQuery.of(context).size.width > 350 ? 40 : 20,
                      child: Center(
                        child: Image(
                          image: widget.icon,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width > 350 ? 10 : 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width > 900
                                  ? 15
                                  : MediaQuery.of(context).size.width > 350
                                  ? 15
                                  : 13,
                              fontFamily: 'SVN-Gotham'),
                        ),
                        Visibility(
                          visible: widget.subtitle != "",
                          child: Text(
                            widget.subtitle,
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width >
                                    900
                                    ? 13
                                    : MediaQuery.of(context).size.width > 350
                                    ? 12
                                    : 11,
                                fontFamily: 'SVN-Gotham'),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
