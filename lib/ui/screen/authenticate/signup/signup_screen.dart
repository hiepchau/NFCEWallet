import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nfc_e_wallet/ui/screen/authenticate/login/login_page.dart';
import '../../../../l10n/l10n.dart';
import '../../../../utils/toast_helper.dart';
import '../../../style/color.dart';
import '../../otp/otp_screen.dart';
import 'signup_bloc.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
  final _dobController = TextEditingController();
  bool _obscurePasswordText = true;
  bool _obscureRePasswordText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePasswordText = !_obscurePasswordText;
    });
  }

  void _toggleRePasswordVisibility() {
    setState(() {
      _obscureRePasswordText = !_obscureRePasswordText;
    });
  }

  DateTime _dob = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupInfoState>(
      listener: (context, state) {
        if (state.signupStatus == SignupStatus.Success) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OTPScreen(phoneNumber: _phoneNumberController.text),
            ),
          );
        } else if (state.signupStatus == SignupStatus.InvalidInfo) {
          ToastHelper.showToast("Register failed", status: ToastStatus.failure);
        }
      },
      child: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            color: primary,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Create Account!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
                        "Already have an account? Sign in",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ]),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32),
                    Column(
                      children: [
                        TextField(
                          controller: _phoneNumberController,
                          decoration: InputDecoration(
                            hintText: 'Your phone number',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onChanged: (value) {},
                        ),
                        SizedBox(height: 24.0),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePasswordText,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _obscurePasswordText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                          ),
                          onChanged: (value) {},
                        ),
                        SizedBox(height: 24.0),
                        TextField(
                          controller: _repeatPasswordController,
                          obscureText: _obscureRePasswordText,
                          decoration: InputDecoration(
                            hintText: 'Repeat Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _obscureRePasswordText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: _toggleRePasswordVisibility,
                            ),
                          ),
                          onChanged: (value) {},
                        ),
                        SizedBox(height: 24.0),
                        TextField(
                          controller: _fullNameController,
                          decoration: InputDecoration(
                            hintText: 'Your full name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onChanged: (value) {},
                        ),
                        SizedBox(height: 24.0),
                        TextField(
                          controller: _identifyIDController,
                          decoration: InputDecoration(
                            hintText: 'Your identify ID',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onChanged: (value) {},
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
                                _dobController.text =
                                    DateFormat('yyyy-MM-dd').format(_dob);
                              });
                          },
                          child: AbsorbPointer(
                            child: TextField(
                              controller: _dobController,
                              decoration: InputDecoration(
                                hintText: 'Date of birth',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                              readOnly: true,
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
                                  _repeatPasswordController.text.isNotEmpty &&
                                  _identifyIDController.text.isNotEmpty &&
                                  _dobController.text.isNotEmpty) {
                                if (_passwordController.text ==
                                    _repeatPasswordController.text) {
                                  context.read<SignupBloc>().add(SignupEvent(
                                      fullName: _fullNameController.text,
                                      phone: _phoneNumberController.text,
                                      password: _passwordController.text,
                                      identifyID: _identifyIDController.text,
                                      dob: _dobController.text));
                                } else {
                                  ToastHelper.showToast(
                                      L10n().enterConfirmPasswordSame,
                                      status: ToastStatus.failure);
                                }
                              } else {
                                ToastHelper.showToast(
                                    L10n().enterFullInformation,
                                    status: ToastStatus.failure);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: onPrimary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
