import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nfc_e_wallet/l10n/l10n.dart';
import 'package:nfc_e_wallet/ui/screen/app_navigator.dart';
import 'package:nfc_e_wallet/ui/screen/authenticate/login_page.dart';

void main() {
  AppNav.init();
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
      child: LoginPage()));
}
