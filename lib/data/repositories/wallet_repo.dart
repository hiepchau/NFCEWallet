import 'package:event_bus/event_bus.dart';
import 'package:logger/logger.dart';
import 'package:nfc_e_wallet/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/wallet.dart';
import '../remote/app_service.dart';
import '../remote/request_factory.dart';

class WalletRepo {
  final EventBus _eventBus;
  final Logger _logger;
  final SharedPreferences _sharedPreferences;
  final AppService _appService;
  final RequestFactory _requestFactory;

  WalletRepo(this._logger, this._sharedPreferences, this._appService,
      this._requestFactory, this._eventBus);

  Future<Wallet?> createWallet(String userId,
      String name, String type, String cardNumber) async {
    return _appService
        .createWallet(userId, _sharedPreferences.getString('token')!,
            _requestFactory.createWallet(name, type, cardNumber))
        .then((http) async {
      print(http.response.statusCode);
      print(http.response.data);
      if (http.response.statusCode != 200) return null;
      return Wallet.fromJson(http.response.data["wallet"]);
    });
  }

  Future<Map<String, dynamic>?> getUserByWallet(String walletId) async {
    return _appService
        .getUserByWallet(walletId, _sharedPreferences.getString('token')!)
        .then((http) async {
      print(http.response.statusCode);
      if (http.response.statusCode != 200) return null;
      return http.response.data;
    });
  }

  Future<List<Wallet>?> getListWallet(String userId) async {
    return _appService
        .getWalletByUserId(userId, _sharedPreferences.getString('token')!)
        .then((http) async {
      if (http.response.statusCode != 200) {
        return null;
      } else {
        print(http.data.toJson());
        return http.data.toListWallet();
      }
    });
  }
}
