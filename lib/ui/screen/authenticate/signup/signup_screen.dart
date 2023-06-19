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
        create: (context) => SignupBloc(),
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
  final _fullNameController = TextEditingController();
  final _identifyIDController = TextEditingController();
  DateTime _dob = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupInfoState>(
      listener: (context, state) {
        if (state.signupStatus == SignupStatus.Success) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPScreen(phoneNumber: _phoneNumberController.text),
            ),
          );
        } else if (state.signupStatus == SignupStatus.InvalidInfo) {
          ToastHelper.showToast("Register failed", status: ToastStatus.failure);
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
                          },
                        ),
                        SizedBox(height: 24.0),
                        TextField(
                          controller: _fullNameController,
                          decoration: InputDecoration(
                            hintText: 'Your full name',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onChanged: (value) {
                          },
                        ),
                        SizedBox(height: 24.0),
                        TextField(
                          controller: _identifyIDController,
                          decoration: InputDecoration(
                            hintText: 'Your identify ID',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onChanged: (value) {
                          },
                        ),
                        SizedBox(height: 24.0),
                        GestureDetector(
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: _dob,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null && pickedDate != _dob)
                              setState(() {
                                _dob = pickedDate;
                              });
                          },
                          child: AbsorbPointer(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Date of Birth ${_dob.toLocal()}'.split(' ')[0],
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_phoneNumberController.text.isNotEmpty &&
                                  _passwordController.text.isNotEmpty &&
                                  _repeatPasswordController.text.isNotEmpty) {
                                context.read<SignupBloc>().add(
                                    SignupEvent(
                                        fullName: _fullNameController.text,
                                        phone: _phoneNumberController.text,
                                        password: _passwordController.text,
                                        identifyID: _identifyIDController.text,
                                        dob: _dob //you might want to convert the dob to DateTime
                                    )
                                );
                              } else {
                                ToastHelper.showToast("Vui lòng nhập đủ thông tin!", status: ToastStatus.failure);
                              }
                            },
                            child: Text('Sign Up'),
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
      ),
    );
  }
}
