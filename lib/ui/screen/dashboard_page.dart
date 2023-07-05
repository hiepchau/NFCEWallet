import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nfc_e_wallet/main.dart';
import 'package:nfc_e_wallet/ui/widgets/shortcut_widget/shortcut_icon.dart';
import '../../utils/list_utils.dart';
import '../../utils/widget_utils.dart';
import '../style/color.dart';
import 'app_navigator.dart';
import 'notification/notification_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> with TickerProviderStateMixin {
  bool isVisible = false;
  late final _adsTabController = TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        title: Text(
          'Xin chào, ${user.full_name}',
          style: TextStyle(color: onPrimary, fontSize: 18),
        ),
        actions: [
          IconButton(
              onPressed: () => 
              notAvailable(),
              // AppNav.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const NotificationPage())),
              icon: Icon(
                Icons.notifications,
                color: onPrimary,
              ))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      buildOverviewBoard(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            ".",
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                            ".",
                            style:
                            TextStyle(color: Colors.black54, fontSize: 25),
                          ),
                          Text(
                            ".",
                            style:
                            TextStyle(color: Colors.black54, fontSize: 25),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Dịch vụ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final width = constraints.maxWidth;
                          final iconLabelWidth = 40.0.w;
                          final labelWidth = iconLabelWidth * 1.5;

                          List<Widget> shortcuts =
                          WidgetUtils.rowEvenlyWidthDivideWrap(
                              width, labelWidth, 4, [
                            ShortcutIcon(
                                Icon(
                                  Icons.phone_android,
                                  color: primary,
                                ),
                                'Nạp tiền ĐT',
                                iconLabelWidth,
                                labelWidth,
                                onTap: notAvailable),
                            ShortcutIcon(
                                Icon(
                                  Icons.receipt_long,
                                  color: Colors.yellow,
                                ),
                                'Thanh toán hóa đơn',
                                iconLabelWidth,
                                labelWidth,
                                onTap: notAvailable),
                            ShortcutIcon(
                                Icon(
                                  Icons.shield,
                                  color: Colors.green,
                                ),
                                'Bảo hiểm',
                                iconLabelWidth,
                                labelWidth,
                                onTap: notAvailable),
                            ShortcutIcon(
                                Icon(
                                  FontAwesomeIcons.piggyBank,
                                  color: Colors.pink,
                                ),
                                'Tài khoản tích lũy',
                                iconLabelWidth,
                                labelWidth,
                                onTap: notAvailable,),
                            ShortcutIcon(
                                Icon(
                                  FontAwesomeIcons.simCard,
                                  color: primary,
                                ),
                                'Nạp 3G/4G',
                                iconLabelWidth,
                                labelWidth,
                                onTap: notAvailable,),
                            ShortcutIcon(
                                Image.asset(
                                    'assets/images/icons/vetc-logo.png'),
                                'VETC',
                                iconLabelWidth,
                                labelWidth,
                                onTap: notAvailable,),
                            ShortcutIcon(
                                Icon(
                                  FontAwesomeIcons.ticket,
                                  color: primary,
                                ),
                                'Đặt vé phim',
                                iconLabelWidth,
                                labelWidth,
                                onTap: notAvailable,),
                            ShortcutIcon(
                                Icon(
                                  Icons.widgets,
                                  color: primary,
                                ),
                                'Tất cả',
                                iconLabelWidth,
                                labelWidth,
                                onTap: notAvailable,),
                          ])
                              .map((e) => Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: e,
                          ))
                              .toList();

                          return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: ListUtils.join(shortcuts,
                                      (i) => const SizedBox(height: 10)));
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final width = constraints.maxWidth;
                          final iconLabelWidth = 40.0.w;
                          final labelWidth = iconLabelWidth * 1.5;

                          List<Widget> shortcuts =
                          WidgetUtils.rowEvenlyWidthDivideWrap(
                              width, labelWidth, 4, [
                            ShortcutIcon(Icon(Icons.abc_outlined),
                                'Mua vé máy bay', iconLabelWidth, labelWidth,
                                onTap: notAvailable,),
                            ShortcutIcon(Icon(Icons.access_alarm_rounded),
                                'KFC', iconLabelWidth, labelWidth,
                                onTap: notAvailable,),
                            ShortcutIcon(Icon(Icons.add_box_rounded),
                                'Jolibee', iconLabelWidth, labelWidth,
                                onTap: notAvailable,),
                            ShortcutIcon(Icon(Icons.add_circle), 'Uniqlo',
                                iconLabelWidth, labelWidth,
                                onTap: notAvailable,),
                          ])
                              .map((e) => Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: e,
                          ))
                              .toList();

                          return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Đề xuất:",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: primary,
                                      ),
                                    )),
                                const SizedBox(
                                  height: 20,
                                )
                              ] +
                                  ListUtils.join(shortcuts,
                                          (i) => const SizedBox(height: 10)));
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final width = constraints.maxWidth;
                          final iconLabelWidth = 40.0.w;
                          final labelWidth = iconLabelWidth * 1.5;

                          List<Widget> shortcuts =
                          WidgetUtils.rowEvenlyWidthDivideWrap(
                              width, labelWidth, 4, [
                            ShortcutIcon(Icon(Icons.abc_outlined),
                                'Mua vé máy bay', iconLabelWidth, labelWidth,
                                onTap: notAvailable),
                            ShortcutIcon(Icon(Icons.access_alarm_rounded),
                                'KFC', iconLabelWidth, labelWidth,
                                onTap: notAvailable),
                            ShortcutIcon(Icon(Icons.add_box_rounded), 'Jolibee',
                                iconLabelWidth, labelWidth),
                            ShortcutIcon(Icon(Icons.add_circle), 'Uniqlo',
                                iconLabelWidth, labelWidth,
                                onTap: notAvailable),
                          ])
                              .map((e) => Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: e,
                          ))
                              .toList();

                          return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Có thể bạn quan tâm:",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: primary,
                                      ),
                                    )),
                                const SizedBox(
                                  height: 20,
                                )
                              ] +
                                  ListUtils.join(shortcuts,
                                          (i) => const SizedBox(height: 10)));
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AspectRatio buildOverviewBoard() {
    return AspectRatio(
      aspectRatio: 70 / 25,
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: TabBarView(
                    controller: _adsTabController,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage(
                                    "assets/images/icons/cantfind.png"))),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage(
                                    "assets/images/icons/cantfind.png"))),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.greenAccent,
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage(
                                    "assets/images/icons/cantfind.png"))),
                      )
                    ],
                  )),
              Text(
                "Đây là quảng cáo",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 900
                      ? 15
                      : MediaQuery.of(context).size.width > 350
                      ? 15
                      : 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
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
