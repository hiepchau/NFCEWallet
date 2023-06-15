import 'package:event_bus/event_bus.dart';
import 'package:logger/logger.dart';
import 'package:nfc_e_wallet/data/model/response/transaction_response.dart';
import 'package:nfc_e_wallet/data/model/wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<bool> createWallet(String name, String type, String cardNumber) async {
    return _appService
        .createWallet('Bearer '+_sharedPreferences.getString('token')!, _requestFactory.createWallet(name, type, cardNumber))
        .then((http) async {
      print(http.response.statusCode);
      return (http.response.statusCode != 200);
    });
  }

  Future<List<Wallet>?> getListWallet(int page) async {
    return _appService
        .getListCarFromPage(page)
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