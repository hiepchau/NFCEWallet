import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_e_wallet/data/model/transaction.dart';
import 'package:nfc_e_wallet/l10n/l10n.dart';
import 'package:nfc_e_wallet/ui/screen/otp/bloc/otp_bloc.dart';
import 'package:nfc_e_wallet/ui/screen/payment/payment_success/payment_success_screen.dart';
import 'package:nfc_e_wallet/ui/screen/root/root_screen.dart';
import 'package:nfc_e_wallet/utils/toast_helper.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rxdart/rxdart.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required this.phoneNumber});
  final String phoneNumber;
  @override
  OTPScreenState createState() => OTPScreenState(phoneNumber: phoneNumber);
}

class OTPScreenState extends State<OTPScreen> {
  final String phoneNumber;
  OTPScreenState({Key? key, required this.phoneNumber});

  final _otpBloc = OtpBloc();
  final _otpController = TextEditingController();
  final _otpStreamController = BehaviorSubject<String>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _otpBloc,
      child: BlocListener<OtpBloc, OtpState>(
        listener: (context, state) {
          if (state is OtpSuccess) {
            if (state.type == "REGISTER") {
              ToastHelper.showToast(L10n.of(context).verifySuccess,
                  status: ToastStatus.success);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RootApp()),
              );
            } else if (state.type == "TRANSFER_TRANSACTION" ||
                state.type == "TRANSACTION") {
              final transaction = Transaction.fromJson(state.data);
              ToastHelper.showToast(L10n.of(context).verifySuccess,
                  status: ToastStatus.success);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PaymentSuccessScreen(
                          transaction: transaction,
                        )),
              );
            }
          } else if (state is OtpFailure) {
            ToastHelper.showToast(
                "${L10n.of(context).verifySuccess}: ${state.error}",
                status: ToastStatus.failure);
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
            title: Text("Enter OTP code",
                style: TextStyle(fontSize: 26, color: Color(0xFF2196F3))),
          ),
          body: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Code sent via Phone Number to",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center),
                  Text(phoneNumber,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
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
                      setState(() {
                        _otpStreamController.add(value);
                      });
                    },
                  ),
                  TextButton(
                    onPressed: () =>
                        context.read<OtpBloc>().add(ResendOtpEvent()),
                    child: Text("Resend Code",
                        style: TextStyle(color: Color(0xFF2196F3))),
                  ),
                  SizedBox(height: 30),
                  StreamBuilder<String>(
                    stream: _otpStreamController.stream,
                    builder: (context, snapshot) {
                      bool isValidLength =
                          snapshot.hasData && snapshot.data!.length == 6;
                      return BlocBuilder<OtpBloc, OtpState>(
                        builder: (context, state) {
                          if (state is OtpLoading) {
                            return CircularProgressIndicator();
                          } else {
                            return ElevatedButton(
                              onPressed: isValidLength
                                  ? () {
                                      print(_otpController.text);
                                      context.read<OtpBloc>().add(
                                          SubmitOtpEvent(_otpController.text,
                                              phoneNumber));
                                    }
                                  : null,
                              child: Text("Continue"),
                              style: ElevatedButton.styleFrom(
                                primary:
                                    isValidLength ? Colors.green : Colors.grey,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10),
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
