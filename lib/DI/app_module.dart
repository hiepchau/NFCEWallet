import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:nfc_e_wallet/data/remote/dio.dart';
import "package:shared_preferences/shared_preferences.dart";

@module
abstract class RegisterModule {
  @singleton
  @Named('baseUrl')
  String get baseUrl => "https://ewallet-server.as.r.appspot.com";

  @singleton
  Logger get logger => Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      printTime: false,
    ),
  );

  @singleton
  EventBus get eventBus => EventBus();

  @singleton
  @preResolve
  Future<SharedPreferences> sharedPreferences() => SharedPreferences.getInstance();

  @lazySingleton
  Dio dio(@Named('baseUrl') String baseUrl, Logger logger) => DioFactory(baseUrl).create(logger);
}