import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:nfc_e_wallet/data/remote/dio.dart';
import "package:shared_preferences/shared_preferences.dart";

import '../data/remote/app_service.dart';
import '../data/remote/request_factory.dart';
import '../data/repositories/authenticator.dart';
import '../data/repositories/user_repo.dart';

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

  @singleton
  AppService appService(Dio dio) => AppService(dio);

  @singleton
  Authenticator authenticator(Logger logger,
      SharedPreferences sharedPreferences,
      AppService appService, RequestFactory requestFactory, EventBus eventBus) =>
      Authenticator(logger, sharedPreferences, appService, requestFactory, eventBus);

  @singleton
  UserRepo userRepo(Logger logger,
      SharedPreferences sharedPreferences,
      AppService appService, RequestFactory requestFactory, EventBus eventBus) =>
      UserRepo(logger, sharedPreferences, appService, requestFactory, eventBus);

  //TODO: ADD REPO
}