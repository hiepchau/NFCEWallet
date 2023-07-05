import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:nfc_e_wallet/ui/screen/root/root_screen.dart';

import 'authenticate_bloc.dart';
import 'login_page.dart';

class AuthenticationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Builder(builder:
          (context)=>
          MultiBlocProvider(
            providers: [
              BlocProvider<AuthenticationBloc>(create: (context) => AuthenticationBloc()),

            ],
            child: BlocListener<AuthenticationBloc, AuthenticationInfoState>(
              listenWhen: (previous, current) => previous.isloggedin != current.isloggedin,
              listener: (context,state){
                if(state.isloggedin == authenticateStatus.Activate) {

                  SmartDialog.dismiss();
                  print("listener triggered "+state.isloggedin.toString());
                }
                if (state.isloggedin == authenticateStatus.unAuthorized) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Wrong username or password.",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                  SmartDialog.dismiss();
                  print("listener triggered "+state.isloggedin.toString());
                }
                if (state.isloggedin == authenticateStatus.Authorizing) {
                  SmartDialog.showLoading(msg: "Logging in...");
                  print("listener triggered "+state.isloggedin.toString());
                }
                if (state.isloggedin == authenticateStatus.Authorized) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Login success.",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                  SmartDialog.dismiss();
                  print("listener triggered "+state.isloggedin.toString());
                }
              },
              child: BlocSelector<AuthenticationBloc,AuthenticationInfoState,authenticateStatus>(
                selector: (state)=>state.isloggedin,
                builder: (context,state)=> state == authenticateStatus.Activate || state == authenticateStatus.unAuthorized ?
                 AnimatedSwitcher(
                    duration: Duration(milliseconds: 250),
                    switchInCurve: Curves.easeIn,
                    child: LoginScreen())
                    :
                const RootApp(),
              ),
            ),
          ),
      );
  }
}