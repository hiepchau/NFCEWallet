import 'dart:convert';
import 'dart:typed_data';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nfc_e_wallet/data/model/user.dart';
import 'package:nfc_e_wallet/data/model/wallet.dart';
import 'package:nfc_e_wallet/data/preferences.dart';
import 'package:nfc_e_wallet/main.dart';
import 'package:nfc_e_wallet/ui/widgets/shortcut_widget/shortcut_panel.dart';
import 'package:nfc_host_card_emulation/nfc_host_card_emulation.dart';

import '../../style/color.dart';
import '../account/account_page.dart';
import '../dashboard_page.dart';
import '../history/history_page.dart';
import '../promo/promo_page.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);
  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> with TickerProviderStateMixin {
  int pageIndex = 0;
  GlobalKey key = GlobalKey();
  late final tabController = TabController(length: 4, vsync: this);

  void checkNFC() async {
    if (isNFCEnable) {
      if (nfcState == NfcState.enabled) {
        await NfcHce.init(
          aid: Uint8List.fromList([0xA0, 0x00, 0xDA, 0xDA, 0xDA, 0xDA, 0xDA]),
          permanentApduResponses: false,
          listenOnlyConfiguredPorts: false,
        );
        initNFC();
      } else {
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
                'Bạn chưa bật NFC, bạn hãy bật và khởi động lại ứng dụng',
                style: TextStyle(color: Colors.white)),
          );
        });
      }
    }
  }

  void initVariables() {
    user = User.fromJson(jsonDecode(prefs.getString(Preferences.user)!));
    final userJson = jsonDecode(prefs.getString(Preferences.user)!);
    for (var wallet in userJson["wallets"]) {
      listWallet.add(Wallet.fromJson(wallet));
      
      if (wallet["type"] == "DefaultWallet") {
        defaultWallet = Wallet.fromJson(wallet);
      }
    }
  }

  void initNFC() async {
    //INIT NFC
    final port = 0;
    // change data to transmit here

    final data = utf8.encode(defaultWallet.id.toString());

    await NfcHce.addApduResponse(port, data);
  }

  @override
  void initState() {
    super.initState();
    initVariables();
    checkNFC();
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
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30))),
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
      physics: NeverScrollableScrollPhysics(),
      controller: tabController,
      children: [
        const Dashboard(),
        const HistoryPage(),
        const PromoPage(),
        AccountPage(),
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
