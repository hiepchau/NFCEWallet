import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:nfc_e_wallet/data/repositories/authenticator.dart';

part 'account_page_event.dart';
part 'account_page_state.dart';

class AccountPageBloc extends Bloc<AccountPageEvent, AccountPageState> {

  AccountPageBloc() : super(AccountPageInitial()) {
    on<LogoutEvent>((event, emit) async {
      var authenticator = GetIt.instance.get<Authenticator>();
      await authenticator.logout();
      emit(AccountLogoutSuccess());
    });
    // handle other events here
  }
}
