import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nfc_e_wallet/ui/screen/otp/otp_screen.dart';
import 'package:nfc_e_wallet/ui/screen/dashboard_page.dart';
import 'package:nfc_e_wallet/utils/toast_helper.dart';
import '../../../l10n/l10n.dart';
import '../../style/color.dart';
import '../root_screen.dart';
import 'login_bloc.dart';
import 'login_event.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          color: Color(0xFF3F63F6),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Welcome Back!',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
                FlatButton(
                  onPressed: () {

                    // navigate to create account screen
                  },
                  child: Text(
                    "Don’t have an account? Create Account",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  color: Colors.transparent,
                ),
                SizedBox(height: 32),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      TextField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          hintText: 'Your phone number',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                        ),
                        onChanged: (value) {
                          // Handle phone number input change
                        },
                      ),
                      SizedBox(height: 24.0),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                          suffixIcon: Icon(Icons.visibility_off), // Eye icon
                        ),
                        onChanged: (value) {
                          context.read<LoginBloc>().add(PasswordChanged(value));
                        },
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            ToastHelper.showToast(L10n.of(context).signInSuccess, status: ToastStatus.success);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RootApp()),
                            );
                          },
                          child: Text('Sign In'),
                          style: ElevatedButton.styleFrom(
                            primary: green1, // Button's fill color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
