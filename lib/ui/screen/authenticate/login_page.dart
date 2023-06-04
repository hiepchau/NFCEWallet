import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_e_wallet/ui/screen/dashboard_page.dart';
import '../root_screen.dart';
import 'login_bloc.dart';
import 'login_event.dart';

enum LoginMethod {
  email,
  phone,
}

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
  LoginMethod _method = LoginMethod.email;
  void _switchMethod() {
    setState(() {
      _method = _method == LoginMethod.email ? LoginMethod.phone : LoginMethod.email;
    });
  }

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
                      _method == LoginMethod.email ? _EmailSignInForm() : _PhoneNumberSignInForm(),
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _switchMethod,
                          child: Text(_method == LoginMethod.email ? 'Sign in with Phone Number' : 'Sign in with Email'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent, // Button's fill color
                            side: BorderSide(color: Color(0xFF3F63F6)), // Border color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RootApp()),
                            );
                          },
                          child: Text('Sign In'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green, // Button's fill color
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

class _EmailSignInForm extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'Enter your email address',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          onChanged: (value) {
            context.read<LoginBloc>().add(EmailChanged(value));
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
      ],
    );
  }
}

class _PhoneNumberSignInForm extends StatelessWidget {
  final _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _phoneNumberController,
      decoration: InputDecoration(
        hintText: 'Your phone number',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      onChanged: (value) {
        // Handle phone number input change
      },
    );
  }
}
