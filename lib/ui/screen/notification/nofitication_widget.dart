import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:nfc_e_wallet/ui/style/color.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  @override
  _NotificationWidget createState() => _NotificationWidget();
}

class _NotificationWidget extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
          child: Row(
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
                    ? 30
                    : MediaQuery.of(context).size.width > 350
                    ? 20
                    : 20,
              ),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width > 900
                                    ? 15
                                    : MediaQuery.of(context).size.width > 350
                                    ? 13
                                    : 12,
                                fontFamily: 'SVN-Gotham'),
                          ),
                          Expanded(
                            child: Text(
                              "2 giờ trước",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width > 900
                                      ? 15
                                      : MediaQuery.of(context).size.width > 350
                                      ? 12
                                      : 12,
                                  fontFamily: 'SVN-Gotham'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.75,
                        child: Text(
                          widget.subtitle,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width > 900
                                  ? 13
                                  : MediaQuery.of(context).size.width > 350
                                  ? 12
                                  : 12,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'SVN-Gotham'),
                        ),
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
