
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'screen/payment/payment_confirm/payment_confirm.dart';
import 'style/color.dart';
import 'widgets/profile_widget.dart';
import 'widgets/toggle_widget.dart';

enum Bank { TPBank, VietcomBank }

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  _WithdrawPage createState() => _WithdrawPage();
}

class _WithdrawPage extends State<WithdrawPage> {
  bool isVisible = false;
  Bank? _bank = Bank.TPBank;
  TextEditingController withdrawController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: onPrimary),
        backgroundColor: primary,
        title: Text(
          'Rút tiền',
          style: TextStyle(color: onPrimary),
        ),
      ),
      body: getBody(context),
    );
  }

  Widget getBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width < 900
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width / 2,
                    maxWidth: MediaQuery.of(context).size.width >= 900
                        ? MediaQuery.of(context).size.width / 2
                        : MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).padding.top + kToolbarHeight)),
                child: IntrinsicHeight(
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
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 15),
                          child: Row(
                            children: [
                              Text(
                                "PHƯƠNG THỨC NHẬN TIỀN",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                            Row(
                              children: [
                                Expanded(
                                  child: ToggleWidget(
                                    icon: AssetImage(
                                        'assets/images/icons/tpbankIcon.png'),
                                    title: "TP Bank",
                                    subtitle: "Miễn phí",
                                    onTap: () {},
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Radio<Bank>(
                                    value: Bank.TPBank,
                                    groupValue: _bank,
                                    onChanged: (Bank? value) => setState(() {
                                      _bank = value;
                                    }),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ToggleWidget(
                                    icon: AssetImage(
                                        'assets/images/icons/vietcombankIcon.png'),
                                    title: "Vietcom Bank",
                                    subtitle: "Miễn phí",
                                    onTap: () {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Radio<Bank>(
                                    value: Bank.VietcomBank,
                                    groupValue: _bank,
                                    onChanged: (Bank? value) => setState(() {
                                      _bank = value;
                                    }),
                                  ),
                                )
                              ],
                            ),
                            ProfileWidget(
                              icon: FontAwesomeIcons.creditCard,
                              iconColor: black,
                              title: 'Rút tiền về ngân hàng',
                              subtitle: "Miễn phí",
                              onTap: () {
                                showModal();
                              },
                            ),
                            ProfileWidget(
                                icon: FontAwesomeIcons.shop,
                                iconColor: black,
                                title: 'Rút tiền tại điểm giao dịch',
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
                                                "Số dư ví: 900.000đ",
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
                                                labelText: "Số tiền cần rút",
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
                  ),
                ))),
      ),
    );
  }

  showModal() => showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (BuildContext context) {
        return const PaymentConfirm(phoneNumber: "0827989868", amount: "1.000.000",); //const PaymentConfirm();
      });
}
