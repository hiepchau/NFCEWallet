import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nfc_e_wallet/data/repositories/authenticator.dart';

part 'authenticate_event.dart';
part 'authenticate_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationInfoState> {
  AuthenticationBloc() : super(AuthenticationInfoState()) {
    on<LoginEvent>((event, emit) async {
      var authenticator = GetIt.instance.get<Authenticator>();
      emit(AuthenticationInfoState(authenStatus: authenticateStatus.Authorizing));
      try
      {
        bool loginstate = await authenticator.login(
            event.phoneNumber as String, event.password as String);

        if(loginstate) {
          print("Login success");
          emit(AuthenticationInfoState(authenStatus: authenticateStatus.Authorized));
        } else {
          print("Log in failed");
          emit(AuthenticationInfoState(authenStatus: authenticateStatus.unAuthorized));
        }
      }
      catch(e)
      {
        if(e is DioError){
          print(e.response!.data);
        }
        print("Log in failed due to exception: $e");

        emit(AuthenticationInfoState(authenStatus: authenticateStatus.unAuthorized));
      }
    });
    on<LogoutEvent>((event, emit) async {
      var authenticator = GetIt.instance.get<Authenticator>();

      try{
        bool logoutstate = await authenticator.logout();
        if(logoutstate) {
          print("Logout success");
          emit(AuthenticationInfoState(authenStatus: authenticateStatus.Activate));
        }
      }
      catch(e){
        if(e is DioError){
          print(e.response!.data);
        }
        print("Log out failed");
        emit(AuthenticationInfoState(
            authenStatus: authenticateStatus.Authorized));
      }
    });
  }
}

