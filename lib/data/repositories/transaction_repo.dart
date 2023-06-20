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

  Future<String?> createTransferTransaction(String fromUser, String toUser, String amount, String message) async {
    return _appService
        .createTransferTransaction(_sharedPreferences.getString('token')!, _requestFactory.createTransferTransaction(fromUser, toUser, amount, message))
        .then((http) async {
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

  Future<bool> createTransaction(String fromUser, String toUser, String amount, String message, String type) async {
    return _appService
        .createTransaction('Bearer '+_sharedPreferences.getString('token')!, _requestFactory.createTransaction(fromUser, toUser, amount, message, type))
        .then((http) async {
      print(http.response.statusCode);
      return (http.response.statusCode != 200);
    });
  }

  Future<List<Transaction>?> getListTransaction(String id) async {
    return _appService
        .getListTransaction(id, 'Bearer '+_sharedPreferences.getString('token')!)
        .then((http) async {
      print(http.response.statusCode);
      if (http.response.statusCode != 200) {
        return [];
      }
      else{
        return http.data.toListTransaction();
      }
    });
  }
}