import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/l10n.dart';
import '../../../../utils/toast_helper.dart';
import '../../../style/color.dart';
import '../../otp/otp_screen.dart';
import 'signup_bloc.dart';


class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignUpBloc(),
        child: SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

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
                  'Create Account',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Already have an account? Sign In",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
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
                          context.read<SignUpBloc>().add(PhoneNumberChanged(value));
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
                          context.read<SignUpBloc>().add(PasswordChanged(value));
                        },
                      ),
                      SizedBox(height: 24.0),
                      TextField(
                        controller: _repeatPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Repeat Password',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                          suffixIcon: Icon(Icons.visibility_off), // Eye icon
                        ),
                        onChanged: (value) {
                          context.read<SignUpBloc>().add(RepeatPasswordChanged(value));
                        },
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_phoneNumberController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty &&
                                _repeatPasswordController.text.isNotEmpty) {
                              context.read<SignUpBloc>().add(SignUpSubmitted());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OTPScreen(phoneNumber: _phoneNumberController.text),
                                ),
                              );
                            } else {
                              ToastHelper.showToast("Vui lòng nhập đủ thông tin!", status: ToastStatus.failure);
                            }
                          },
                          child: Text('Sign Up'),
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
