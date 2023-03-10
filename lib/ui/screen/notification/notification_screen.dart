import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nfc_e_wallet/ui/style/color.dart';
import 'package:nfc_e_wallet/ui/screen/notification/nofitication_widget.dart';
import '../app_navigator.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreen createState() => _NotificationScreen();
}

class _NotificationScreen extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: onPrimary),
        backgroundColor: primary,
        title: Text(
          'Thông báo',
          style: TextStyle(color: onPrimary),
        ),
      ),
      body: getBody(context),
    );
  }

  Widget getBody(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Column(
          children: [
            Container(
              height: 55,
              padding: const EdgeInsets.all(10),
              child: TabBar(
                  isScrollable: true,
                  unselectedLabelColor: Colors.black.withOpacity(0.3),
                  indicator: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(25)),
                          side: BorderSide(width: 2, color: primary))),
                  indicatorColor: primary,
                  labelColor: primary,
                  tabs: const [
                    Text(
                      "Tất cả",
                    ),
                    Text(
                      "Nhắc nhở",
                    ),
                    Text(
                      "Giao dịch",
                    ),
                    Text(
                      "Khuyến mãi",
                    ),
                  ]),
            ),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width < 900
                            ? MediaQuery.of(context).size.width
                            : MediaQuery.of(context).size.width / 2,
                        maxWidth: MediaQuery.of(context).size.width >= 900
                            ? MediaQuery.of(context).size.width / 2
                            : MediaQuery.of(context).size.width),
                    child: TabBarView(children: [
                      everythingScreen(),
                      notifyScreen(),
                      transferistoryScreen(),
                      promoScreen(),
                    ])),
              ),
            )
          ],
        ));
  }

  Widget everythingScreen() {
    return ListView(
      padding: const EdgeInsets.all(5),
      children: listNotification,
    );
  }

  Widget notifyScreen() {
    return nothingScreen();
  }

  Widget transferistoryScreen() {
    return ListView(
      padding: const EdgeInsets.all(5),
      children: listNotification,
    );
    ;
  }

  Widget promoScreen() {
    return nothingScreen();
  }

  Widget nothingScreen(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 3,
                child: Image.asset(
                  "assets/images/icons/cantfind.png",
                )),
            Text(
              "Bạn chưa có thông báo nào cả!",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 900
                    ? 18
                    : MediaQuery.of(context).size.width > 350
                    ? 18
                    : 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width > 900
                  ? 20
                  : MediaQuery.of(context).size.width > 350
                  ? 10
                  : 10,
            ),
            Text(
              "Tất cả thông báo sẽ được lưu ở đây",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 900
                      ? 15
                      : MediaQuery.of(context).size.width > 350
                      ? 13
                      : 12,
                  color: Colors.black54),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width > 900
                  ? 20
                  : MediaQuery.of(context).size.width > 350
                  ? 10
                  : 10,
            ),
            TextButton(
                onPressed: () => AppNav.pop(context),
                child: Container(
                  height: 35,
                  width: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: primary,
                  ),
                  child: Text(
                    "Trang chủ",
                    style: TextStyle(color: onPrimary),
                  ),
                ))
          ]),
    );
  }

  List<Widget> listNotification = const [
    NotificationWidget(
        icon: FontAwesomeIcons.moneyBillTransfer,
        iconColor: Colors.green,
        title: "Chuyển 200k cho Khôi Nghi",
        subtitle:
        "Bạn thực hiện giao dịch chuyển tiền cho Khôi Nghi với số tiền giao dịch là 200.000đ vào lúc 17:05 17/01/2023"),
    NotificationWidget(
        icon: FontAwesomeIcons.moneyBillTransfer,
        iconColor: Colors.green,
        title: "Chuyển 200k cho Khôi Nghi",
        subtitle:
        "Bạn thực hiện giao dịch chuyển tiền cho Khôi Nghi với số tiền giao dịch là 200.000đ vào lúc 17:05 17/01/2023"),
    NotificationWidget(
        icon: FontAwesomeIcons.moneyBillTransfer,
        iconColor: Colors.green,
        title: "Chuyển 200k cho Khôi Nghi",
        subtitle:
        "Bạn thực hiện giao dịch chuyển tiền cho Khôi Nghi với số tiền giao dịch là 200.000đ vào lúc 17:05 17/01/2023"),
    NotificationWidget(
        icon: FontAwesomeIcons.moneyBillTransfer,
        iconColor: Colors.green,
        title: "Chuyển 200k cho Khôi Nghi",
        subtitle:
        "Bạn thực hiện giao dịch chuyển tiền cho Khôi Nghi với số tiền giao dịch là 200.000đ vào lúc 17:05 17/01/2023"),
  ];
}
