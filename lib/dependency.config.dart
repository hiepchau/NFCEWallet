// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i7;
import 'package:event_bus/event_bus.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i4;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import 'data/remote/app_service.dart' as _i8;
import 'data/remote/request_factory.dart' as _i5;
import 'data/repositories/authenticator.dart' as _i9;
import 'data/repositories/transaction_repo.dart' as _i10;
import 'data/repositories/user_repo.dart' as _i11;
import 'data/repositories/wallet_repo.dart' as _i12;
import 'DI/app_module.dart' as _i13;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.EventBus>(registerModule.eventBus);
  gh.singleton<_i4.Logger>(registerModule.logger);
  gh.factory<_i5.RequestFactory>(() => _i5.RequestFactory());
  await gh.singletonAsync<_i6.SharedPreferences>(
    () => registerModule.sharedPreferences(),
    preResolve: true,
  );
  gh.singleton<String>(
    registerModule.baseUrl,
    instanceName: 'baseUrl',
  );
  gh.lazySingleton<_i7.Dio>(() => registerModule.dio(
        gh<String>(instanceName: 'baseUrl'),
        gh<_i4.Logger>(),
      ));
  gh.singleton<_i8.AppService>(registerModule.appService(gh<_i7.Dio>()));
  gh.singleton<_i9.Authenticator>(registerModule.authenticator(
    gh<_i4.Logger>(),
    gh<_i6.SharedPreferences>(),
    gh<_i8.AppService>(),
    gh<_i5.RequestFactory>(),
    gh<_i3.EventBus>(),
  ));
  gh.singleton<_i10.TransactionRepo>(registerModule.transactionRepo(
    gh<_i4.Logger>(),
    gh<_i6.SharedPreferences>(),
    gh<_i8.AppService>(),
    gh<_i5.RequestFactory>(),
    gh<_i3.EventBus>(),
  ));
  gh.singleton<_i11.UserRepo>(registerModule.userRepo(
    gh<_i4.Logger>(),
    gh<_i6.SharedPreferences>(),
    gh<_i8.AppService>(),
    gh<_i5.RequestFactory>(),
    gh<_i3.EventBus>(),
  ));
  gh.singleton<_i12.WalletRepo>(registerModule.walletRepo(
    gh<_i4.Logger>(),
    gh<_i6.SharedPreferences>(),
    gh<_i8.AppService>(),
    gh<_i5.RequestFactory>(),
    gh<_i3.EventBus>(),
  ));
  return getIt;
}

class _$RegisterModule extends _i13.RegisterModule {}
