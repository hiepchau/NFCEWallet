import 'dart:async';
import 'dart:convert';

import 'package:event_bus/event_bus.dart';
import 'package:logger/logger.dart';
import 'package:nfc_e_wallet/data/preferences.dart';
import 'package:nfc_e_wallet/event_bus/events/authen_event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

import '../remote/app_service.dart';
import '../remote/request_factory.dart';

class Authenticator {
  final EventBus _eventBus;
  final Lock _refreshTaskLock = Lock();
  final Logger _logger;
  final SharedPreferences _sharedPreferences;
  final AppService _appService;
  final RequestFactory _requestFactory;
  Timer? _refreshTask;

  Authenticator(this._logger, this._sharedPreferences, this._appService,
      this._requestFactory, this._eventBus);

  Future<bool> login(String username, String password) async {
    return _appService
        .login(_requestFactory.createLogin(username, password))
        .then((http) async {
      print("LOGIN: $http.response.statusCode");
      if (http.response.statusCode != 200) {
        return false;
      }
      bool isSuccess = false;

      isSuccess = (http.data.accessToken['token'] as String).isNotEmpty;
      final user = http.data.user;
      if (isSuccess) {
        var token = http.data.accessToken['token'] as String;

        await _sharedPreferences.remove(Preferences.token);
        await _sharedPreferences.setString(Preferences.token, token);

        await _sharedPreferences.remove(Preferences.user);
        await _sharedPreferences.setString(Preferences.user, jsonEncode(user));

        _eventBus.fire(EBAuthenEvent(true));
        _logger.i("New token received: $token");
      }
      return isSuccess;
    });
  }

  // Future<bool> logout() async {
  //   return _appService
  //       .logout('Bearer ' + _sharedPreferences.getString(Preferences.token)!)
  //       .then((http) async {
  //     if (http.response.statusCode != 200) {
  //       return false;
  //     }
  //     await _sharedPreferences.remove(Preferences.token);
  //     return true;
  //   });
  // }

  Future<void> logout() async {
    await _sharedPreferences.remove(Preferences.token);
    await _sharedPreferences.remove(Preferences.user);
    _eventBus.fire(EBAuthenEvent(false));
    _logger.i("User logged out");
  }

  Future<String?> register(String fullName, String password, String phone,
      String identifyID, String dob) async {
    return _appService
        .register(_requestFactory.createRegister(
            fullName, password, phone, identifyID, dob))
        .then((http) {
      print(http.response.statusCode);
      if (http.response.statusCode != 200) {
        return null;
      }
      String? otp;

      if (http.data['message'] == 'OTP SENT') {
        otp = http.data['otp'];
        print("OTP received: $otp");
      }
      return otp;
    });
  }

  Future<bool> verify() async {
    return _appService
        .verify('Bearer ' + _sharedPreferences.getString(Preferences.token)!)
        .then((http) async {
      if (http.response.statusCode != 200) {
        return false;
      }
      final authenticationStatus = http.response.data["AUTHENTICATION_STATUS"];
      bool isSuccess = authenticationStatus is bool
          ? authenticationStatus
          : authenticationStatus.toLowerCase() == 'true';

      return isSuccess;
    });
  }

  Future<bool> verifyOtp(String otp, String phoneNumber) async {
    return _appService
        .verifyOtp(_requestFactory.createOtp(otp, phoneNumber))
        .then((http) async {
      print("VERIFY OTP: ${http.response.statusCode}");
      return (http.response.statusCode != 200);
    });
  }

  Future<bool> changePassword(
      String id, String oldPassword, String newPassword) async {
    return _appService
        .changePassword(
            id, _requestFactory.changePassword(oldPassword, newPassword))
        .then((http) async {
      final msg = http.response.data["message"];
      return (http.response.statusCode != 200);
    });
  }
}
