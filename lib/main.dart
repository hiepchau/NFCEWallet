import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:nfc_e_wallet/data/model/wallet.dart';
import 'package:nfc_e_wallet/l10n/l10n.dart';
import 'package:nfc_e_wallet/ui/screen/app_navigator.dart';
import 'package:nfc_e_wallet/ui/screen/authenticate/login/authenticate_page.dart';
import 'package:nfc_e_wallet/utils/nfc_manager.dart';
import 'package:nfc_e_wallet/utils/notification_manager.dart';
import 'package:nfc_host_card_emulation/nfc_host_card_emulation.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/model/user.dart';
import 'data/preferences.dart';
import 'dependency.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

late SharedPreferences prefs;
late User user;
late bool isNFCEnable;
late bool isAuthByFingerprint;
late NfcState nfcState;
late NFCManager nfcManager;
late List<Wallet> listWallet;
late Wallet defaultWallet;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationManager.initialize();
  AppNav.init();
  await configureDependencies();
  //INIT PREFERENCES
  prefs = await SharedPreferences.getInstance();
  isNFCEnable = prefs.getBool("NFC") ?? false;
  isAuthByFingerprint = prefs.getBool("AuthByFingerprint") ?? false;

  //INIT NFC
  nfcManager = NFCManager();
  nfcState = await NfcHce.checkDeviceNfcState();

  runApp(ScreenUtilInit(
      designSize: kIsWeb ? const Size(790, 620) : const Size(390, 800),
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              scaffoldBackgroundColor: Colors.white,
              fontFamily: 'SVN-Gotham',
              textTheme: const TextTheme(
                headlineSmall: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )),
          builder: FlutterSmartDialog.init(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            L10n.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
          home: child, //TODO: change back to login page
        );
      },
      child: AuthenticationPage()));
}
