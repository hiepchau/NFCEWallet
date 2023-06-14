import 'package:event_bus/event_bus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/transaction.dart';
import '../remote/app_service.dart';
import '../remote/request_factory.dart';

class TransactionRepo{
  final EventBus _eventBus;
  final Logger _logger;
  final SharedPreferences _sharedPreferences;
  final AppService _appService;
  final RequestFactory _requestFactory;

  TransactionRepo(this._logger, this._sharedPreferences, this._appService,
      this._requestFactory, this._eventBus);

  Future<Transaction?> getUser(String fromUser, String toUser, String amount, String message) async {
    return _appService
        .createTransferTransaction('Bearer '+_sharedPreferences.getString('token')!, _requestFactory.createTransaction(fromUser, toUser, amount, message))
        .then((http) async {
      print(http.response.statusCode);
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toTransaction();
      }
    });
  }
}