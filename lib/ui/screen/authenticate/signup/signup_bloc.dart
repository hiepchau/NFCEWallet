import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../data/repositories/authenticator.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent,SignupInfoState>{
  SignupBloc(): super(SignupInfoState()){
    on<SignupEvent>((event,emit) async {
      var authenticator = GetIt.instance.get<Authenticator>();
      try {
        String? otp = await authenticator.register(
          event.fullName as String,
          event.password as String,
          event.phone as String,
          event.identifyID as String,
          event.dob as String,
        );
        if(otp != null) {
          print("Register success. OTP: $otp");
          emit(SignupInfoState(signupStatus: SignupStatus.Success));
        }
      } catch (e)
      {
        print("Register failed due to exception: $e");
        emit(SignupInfoState(
            signupStatus: SignupStatus.InvalidInfo));
      }
    });
  }
}

