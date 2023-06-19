import 'package:event_bus/event_bus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/wallet.dart';
import '../remote/app_service.dart';
import '../remote/request_factory.dart';

class WalletRepo{
  final EventBus _eventBus;
  final Logger _logger;
  final SharedPreferences _sharedPreferences;
  final AppService _appService;
  final RequestFactory _requestFactory;

  WalletRepo(this._logger, this._sharedPreferences, this._appService,
      this._requestFactory, this._eventBus);

  Future<Wallet?> createWallet(String name, String type, String cardNumber) async {
    return _appService
        .createWallet(_sharedPreferences.getString('token')!, _requestFactory.createWallet(name, type, cardNumber))
        .then((http) async {
      print(http.response.statusCode);
      print(http.response.data);
      if(http.response.statusCode!=200) return null;
      return http.response.data.wallet;
    });
  }

  Future<List<Wallet>?> getListWallet(String userId) async {
    return _appService
        .getWalletByUserId(userId, _sharedPreferences.getString('token')!)
        .then((http) async {
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toListWallet();
      }
    });
  }
}