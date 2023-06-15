import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_e_wallet/utils/toast_helper.dart';
import '../../../../l10n/l10n.dart';
import '../../../style/color.dart';
import '../../root_screen.dart';
import '../signup/signup_screen.dart';
import 'authenticate_bloc.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthenticationBloc(),
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
    return BlocListener<AuthenticationBloc, AuthenticationInfoState>(
        listener: (context, state) {
          if (state.isloggedin == authenticateStatus.Authorized) {
            ToastHelper.showToast(L10n.of(context).signInSuccess, status: ToastStatus.success);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const RootApp()),
            );
          }
        },
        child: Stack(
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
                      width: 45,
                      height: 45,
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
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: Text(
                        "Don’t have an account? Create Account",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
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

                            },
                          ),
                          SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_phoneNumberController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                                  print("ACTIONN");
                                  context.read<AuthenticationBloc>().add(
                                    LoginEvent(
                                      _phoneNumberController.text,
                                      _passwordController.text,
                                    ),
                                  );
                                } else {
                                  ToastHelper.showToast('Please fill out all fields', status: ToastStatus.failure);
                                }
                              },
                              child: Text('Sign In'),
                              style: ElevatedButton.styleFrom(
                                primary: green1,
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
        )
    );

  }
}
