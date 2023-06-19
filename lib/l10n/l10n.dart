import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/messages_all.dart';

class L10nDelegate extends LocalizationsDelegate<L10n> {
  const L10nDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'vi'].contains(locale.languageCode);

  @override
  Future<L10n> load(Locale locale) => L10n.load(locale);

  @override
  bool shouldReload(L10nDelegate old) => false;
}


class L10n {
  static final L10nDelegate delegate = L10nDelegate();
  static const List<Locale> all = <Locale>[
    Locale('vi', 'VN'), // Vietnamese, Vietnam
    // You can add more supported locales here
  ];
  //
  static Future<L10n> load(Locale locale) {
    final String name = locale.countryCode!.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return L10n();
    });
  }

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n)!;
  }

  String get account {
    return Intl.message(
      'Tài khoản',
      name: 'account',
      desc: 'Tài khoản',
    );
  }

  String get accountNotExist {
    return Intl.message(
      'Tài khoản không tồn tại!',
      name: 'accountNotExist',
      desc: 'Tài khoản không tồn tại!',
    );
  }

  String get accountUpdateFailed {
    return Intl.message(
      'Thiết lập tài khoản thất bại!',
      name: 'accountUpdateFailed',
      desc: 'Thiết lập tài khoản thất bại!',
    );
  }

  String get signIn {
    return Intl.message(
      'Đăng nhập',
      name: 'signIn',
      desc: 'Đăng nhập',
    );
  }

  String get signInFailed {
    return Intl.message(
      'Đăng nhập thất bại!',
      name: 'signInFailed',
      desc: 'Đăng nhập thất bại!',
    );
  }

  String get signInSuccess {
    return Intl.message(
      'Đăng nhập thành công!',
      name: 'signInSuccess',
      desc: 'Đăng nhập thành công!',
    );
  }

  String get verifyCode {
    return Intl.message(
      'Mã xác thực',
      name: 'verifyCode',
      desc: 'Mã xác thực',
    );
  }
  String get verifySuccess {
    return Intl.message(
      'Xác thực thành công!',
      name: 'verifySuccess',
      desc: 'Xác thực thành công!',
    );
  }

  String get verifyFailed {
    return Intl.message(
      'Xác thực thất bại!',
      name: 'verifyFailed',
      desc: 'Xác thực thất bại!',
    );
  }
  String get verifyCodeFailed {
    return Intl.message(
      'Mã xác thực không đúng!',
      name: 'verifyCodeFailed',
      desc: 'Mã xác thực không đúng!',
    );
  }

  String get signOut {
    return Intl.message(
      'Đăng xuất',
      name: 'signOut',
      desc: 'Đăng xuất',
    );
  }

  String get signOutSuccess {
    return Intl.message(
      'Đăng xuất thành công!',
      name: 'signOutSuccess',
      desc: 'Đăng xuất thành công!',
    );
  }

  String get signOutFailed {
    return Intl.message(
      'Đăng xuất thất bại!',
      name: 'signOutFailed',
      desc: 'Đăng xuất thất bại!',
    );
  }

  String get enterConfirmPasswordSame {
    return Intl.message(
      'Vui lòng nhập lại mật khẩu khớp với mật khẩu!',
      name: 'enterConfirmPasswordSame',
      desc: 'Vui lòng nhập lại mật khẩu khớp với mật khẩu!',
    );
  }

  String get enterFullInformation {
    return Intl.message(
      'Vui lòng nhập đủ thông tin!',
      name: 'enterFullInformation',
      desc: 'Vui lòng nhập đủ thông tin!',
    );
  }
}

