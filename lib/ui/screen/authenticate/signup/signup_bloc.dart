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
        bool registerstate = await authenticator.register(
            event.fullName as String,
            event.password as String,
            event.phone as String,
            event.identifyID as String,
            event.dob as DateTime,);
        if(registerstate) {
          print("Register success");
          emit(SignupInfoState(signupStatus: SignupStatus.Success));
        }
      } catch (e)
      {
        print("Register failed");
        emit(SignupInfoState(
            signupStatus: SignupStatus.InvalidInfo));
        // timer!.cancel();
      }
    });
  }
}
