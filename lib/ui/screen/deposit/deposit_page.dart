import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nfc_e_wallet/data/model/wallet.dart';
import 'package:nfc_e_wallet/main.dart';
import 'package:nfc_e_wallet/ui/screen/payment/payment_confirm/payment_confirm.dart';
import 'package:nfc_e_wallet/ui/screen/wallet/bloc/wallet_bloc.dart';
import 'package:nfc_e_wallet/ui/style/color.dart';
import 'package:nfc_e_wallet/ui/widgets/profile_widget.dart';
import 'package:nfc_e_wallet/ui/widgets/toggle_widget.dart';

enum Bank { TPBank, VietcomBank }

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  _DepositPage createState() => _DepositPage();
}

class _DepositPage extends State<DepositPage> {
  bool isVisible = false;
  Wallet defaulWallet = Wallet(1, 0, "0", "0");
  int groupValue = -1;
  Bank? _bank = Bank.TPBank;
  TextEditingController withdrawController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: BackButton(color: onPrimary),
        backgroundColor: primary,
        title: Text(
          'Nạp tiền',
          style: TextStyle(color: onPrimary),
        ),
      ),
      body: BlocProvider(
        create: (context) => WalletBloc()..add(InitWalletEvent()),
        child: getBody(context),
      ),
    );
  }

  Widget getBody(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        final listWallet = state.listWallet;
        for (Wallet wallet in listWallet!) {
          if (wallet.type == "DefaultWallet") defaulWallet = wallet;
        }
        return SingleChildScrollView(
          child: Center(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                      minHeight: 0,
                      maxHeight: MediaQuery.of(context).size.height -
                          MediaQueryData.fromView(View.of(context))
                              .padding
                              .top -
                          kToolbarHeight),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15),
                        child: Row(
                          children: [
                            Icon(
                              Icons.shield,
                              color: green,
                              size: MediaQuery.of(context).size.width > 350
                                  ? 35
                                  : 20,
                            ),
                            Text("Bảo mật tuyện đối theo chuẩn cao nhất")
                          ],
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 15),
                          child: Row(
                            children: [
                              Text(
                                "PHƯƠNG THỨC NẠP TIỀN",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Container(
                          padding: MediaQuery.of(context).size.width > 350
                              ? EdgeInsets.all(10)
                              : EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    color: grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2))
                              ]),
                          child: Column(children: [
                            ToggleWidget(
                              icon: AssetImage(
                                  'assets/images/icons/tpbankIcon.png'),
                              title: "TP Bank",
                              subtitle: "Miễn phí",
                              value: 0,
                              groupValue: groupValue,
                              onChanged: (newValue) {
                                setState(() => groupValue = newValue!);
                              },
                            ),
                            ToggleWidget(
                              icon: AssetImage(
                                  'assets/images/icons/vietcombankIcon.png'),
                              title: "Vietcom Bank",
                              subtitle: "Miễn phí",
                              value: 1,
                              groupValue: groupValue,
                              onChanged: (newValue) {
                                setState(() => groupValue = newValue!);
                              },
                            ),
                            ProfileWidget(
                              icon: FontAwesomeIcons.creditCard,
                              iconColor: black,
                              title: 'Nạp tiền bằng thẻ ngân hàng',
                              subtitle: "Miễn phí",
                              onTap: () {
                                showModal();
                              },
                            ),
                            ProfileWidget(
                                icon: FontAwesomeIcons.shop,
                                iconColor: black,
                                title: 'Nạp tiền tại điểm giao dịch',
                                subtitle: "Miễn phí",
                                onTap: () {
                                  showModal();
                                }),
                          ]),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration:
                                  BoxDecoration(color: white, boxShadow: [
                                BoxShadow(
                                    color: grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2))
                              ]),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 15,
                                              bottom: 5),
                                          child: Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                        offset:
                                                            const Offset(0, 2))
                                                  ]),
                                              child: Text(
                                                "Số dư ví: ${formatCurrency(defaulWallet.balance.toString())}đ",
                                                style:
                                                    TextStyle(color: primary),
                                              )),
                                        ),
                                      ),
                                    ]),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            child: TextFormField(
                                              controller: withdrawController,
                                              decoration: InputDecoration(
                                                hoverColor: primaryContainer,
                                                focusColor: primary,
                                                filled: true,
                                                fillColor: Colors.white,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 15),
                                                labelText: "Số tiền cần nạp",
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: primary),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: grey.withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 2)),
                                            ],
                                          ),
                                          child: Center(
                                            child: TextButton(
                                              onPressed: () =>
                                                  withdrawController.text =
                                                      "100.000",
                                              child: Text("100.000đ",
                                                  style: const TextStyle(
                                                      fontSize: 13)),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: grey.withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 2)),
                                            ],
                                          ),
                                          child: Center(
                                            child: TextButton(
                                              onPressed: () =>
                                                  withdrawController.text =
                                                      "200.000",
                                              child: Text("200.000đ",
                                                  style: const TextStyle(
                                                      fontSize: 13)),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: grey.withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 2)),
                                            ],
                                          ),
                                          child: Center(
                                            child: TextButton(
                                              onPressed: () =>
                                                  withdrawController.text =
                                                      "500.000",
                                              child: Text("500.000đ",
                                                  style: const TextStyle(
                                                      fontSize: 13)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 15),
                                            child: Container(
                                                margin: const EdgeInsets.all(0),
                                                decoration: const BoxDecoration(
                                                    color: green,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: TextButton(
                                                  onPressed: () {
                                                    showModal();
                                                  },
                                                  child: const Text(
                                                    'Tiếp tục',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        )
                                      ],
                                    )
                                  ]),
                            )
                          ],
                        ),
                      )
                    ],
                  ))),
        );
      },
    );
  }

  List<Widget> buildListWallet(List<Wallet> listWallet) {
    List<Widget> listWidget = List<Widget>.empty(growable: true);
    for (int i = 0; i < listWallet.length; i) {
      Wallet wallet = listWallet[i];
      if (wallet.type == "Bank") {
        listWidget.add(
          ToggleWidget(
            icon: AssetImage('assets/images/icons/vietcombankIcon.png'),
            title: wallet.name.toString(),
            subtitle: "Miễn phí",
            value: i,
            groupValue: groupValue,
            onChanged: (newValue) {
              setState(() => groupValue = newValue!);
            },
          ),
        );
      }
    }
    return listWidget;
  }

  String formatCurrency(String amount) {
    final currencyFormat = NumberFormat("#,##0.##");
    return currencyFormat.format(int.parse(amount));
  }

  showModal() => showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (BuildContext context) {
        return PaymentConfirm(
          type: "DEPOSIT",
          receiverPhoneNumber: user.phone_number,
          amount: withdrawController.text.toString(),
        );
      });
}
