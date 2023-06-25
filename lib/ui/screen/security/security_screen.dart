import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_e_wallet/main.dart';
import 'package:nfc_e_wallet/ui/screen/security/bloc/security_bloc.dart';
import 'package:nfc_e_wallet/ui/screen/wallet/bloc/wallet_bloc.dart';
import '../../style/color.dart';

class SecurityScreen extends StatefulWidget {
  @override
  SecurityScreenState createState() => SecurityScreenState();
}

class SecurityScreenState extends State<SecurityScreen> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(
          'Bảo mật',
          style: TextStyle(color: onPrimary),
        ),
        leading: BackButton(color: onPrimary),
      ),
      body: BlocProvider(
        create: (context) => SecurityBloc(isAuthByFingerprint, isNFCEnable),
        child: getBody(context),
      ),
    );
  }
}

Widget getBody(BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width < 900
                      ? MediaQuery.of(context).size.width
                      : MediaQuery.of(context).size.width / 2,
                  maxWidth: MediaQuery.of(context).size.width >= 900
                      ? MediaQuery.of(context).size.width / 2
                      : MediaQuery.of(context).size.width),
              child: getSecuritySection(context),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget getSecuritySection(BuildContext context) {
  return BlocBuilder<SecurityBloc, SecurityState>(
    builder: (context, state) {
      bool isAuthByFingerprint = state.isAuthByFingerprint;
      bool isNFCEnable = state.isNFCEnable;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 2))
                    ]),
                child: Column(children: [
                  Text(
                    "Bảo mật",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width > 900
                            ? 18
                            : MediaQuery.of(context).size.width > 350
                                ? 16
                                : 13,
                        fontWeight: FontWeight.w700,
                        color: primary),
                  ),
                  Row(
                    children: [
                      const Expanded(child: Text("Xác thực bằng vân tay")),
                      Switch(
                          value: isAuthByFingerprint,
                          activeColor: primary,
                          onChanged: (value) {
                            context
                                .read<SecurityBloc>()
                                .add(SwitchFingerprintEvent(value));
                          })
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(child: Text("Thanh toán bằng NFC")),
                      Switch(
                          value: isNFCEnable,
                          activeColor: primary,
                          onChanged: (value) {
                            context
                                .read<SecurityBloc>()
                                .add(SwitchNFCEvent(value));
                          })
                    ],
                  )
                ])),
          ],
        ),
      );
    },
  );
}
