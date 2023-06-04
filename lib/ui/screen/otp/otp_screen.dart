import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_e_wallet/ui/screen/root_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'otp_bloc.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OTPScreen extends StatelessWidget {
  final String phoneNumber;
  OTPScreen({Key? key, required this.phoneNumber}) : super(key: key);

  final _otpController = TextEditingController();
  final _otpBloc = OtpBloc(otpService: OtpService());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _otpBloc,
      child: BlocListener<OtpBloc, OtpState>(
        listener: (context, state) {
          if (state is OtpSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RootApp()),
            );
          } else if (state is OtpFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.error)),
              );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Color(0xFF2196F3)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text("Enter OTP code", style: TextStyle(fontSize: 26, color: Color(0xFF2196F3))),
          ),
          body: BlocConsumer<OtpBloc, OtpState>(
              listener: (context, state) {
                if (state is OtpSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RootApp()),
                  );
                } else if (state is OtpFailure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                }
              },
              builder: (context, state) {
                return Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Code sent via Phone Number to", style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
                        Text(phoneNumber, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        SizedBox(height: 30),
                        PinCodeTextField(
                          appContext: context,
                          length: 6,
                          obscureText: false,
                          controller: _otpController,
                          keyboardType: TextInputType.number,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                          ),
                          onChanged: (value) {
                          },
                        ),
                        TextButton(
                          onPressed: () => context.read<OtpBloc>().add(ResendOtp()),
                          child: Text("Resend Code", style: TextStyle(color: Color(0xFF2196F3))),
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            if (_otpController.text.isNotEmpty) {
                              context.read<OtpBloc>().add(SubmitOtp(_otpController.text));
                            }
                          },
                          child: Text("Continue"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
          ),
        ),
      ),
    );
  }
}
