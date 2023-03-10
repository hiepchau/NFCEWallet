import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nfc_e_wallet/ui/style/color.dart';
import 'package:nfc_e_wallet/ui/widgets/shortcut_panel.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);
  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> with TickerProviderStateMixin {
  int pageIndex = 0;
  GlobalKey key = GlobalKey();
  late final tabController = TabController(length: 4, vsync: this);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: getTabs(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30))
                ),
                builder: (BuildContext context) {
                  return const ShortcutPanel(); //const PaymentConfirm();
                });
            //selectedTab(4);
            // Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScreen()));
          });
        },
        backgroundColor: primary,
        shape: const CircleBorder(),
        child: Icon(
          FontAwesomeIcons.wallet,
          size: 30,
          color: onPrimary,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: getBody(),
    );
  }

  Widget getTabs() {
    List<IconData> iconsItems = [
      MaterialCommunityIcons.home,
      MaterialCommunityIcons.history,
      MaterialCommunityIcons.ticket_percent,
      MaterialCommunityIcons.account,
    ];
    return AnimatedBottomNavigationBar(
      key: key,
      activeColor: primary,
      splashColor: primary,
      inactiveColor: secondary,
      icons: iconsItems,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 25,
      rightCornerRadius: 10,
      activeIndex: pageIndex,
      onTap: (index) {
        setState(() {
          selectedTab(index);
        });
      },
    );
  }

  Widget getBody() {
    return TabBarView(
      controller: tabController,
      children: [
        // Dashboard(),
        // HistoryPage(),
        // PromoPage(),
        // AccountPage(),
      ],
    );
  }

  selectedTab(index) {
    setState(() {
      if (pageIndex != index) {
        tabController.index = index;
        pageIndex = index;
      }
    });
  }
}
