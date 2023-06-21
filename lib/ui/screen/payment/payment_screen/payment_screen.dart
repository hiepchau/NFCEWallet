import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:nfc_e_wallet/data/preferences.dart';
import 'package:nfc_e_wallet/main.dart';
import 'package:nfc_e_wallet/ui/screen/payment/payment_screen/bloc/payment_screen_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../style/color.dart';
import '../payment_confirm/payment_confirm.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentScreenBloc(),
      child: PaymentPage(),
    );
  }
}

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});
  @override
  State<PaymentPage> createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  late Map<String, dynamic> user;

  @override
  void initState() {
    super.initState();
    user = jsonDecode(prefs.getString(Preferences.user)!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocBuilder<PaymentScreenBloc, PaymentScreenState>(
        builder: (context, state) {
          TextEditingController _typeAheadController = TextEditingController(
              text: context.read<PaymentScreenBloc>().phoneNumberInput);
          String message = state.message;
          String amount = state.amount;
          String phoneNumber = state.phoneNumber;
          amountController.text = amount;
          messageController.text = message;
          phoneNumberController.text = phoneNumber;

          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                'Chuyển tiền',
                style: TextStyle(color: onPrimary),
              ),
              leading: BackButton(color: onPrimary),
              backgroundColor: primary,
            ),
            body: Column(
              children: [
                AspectRatio(
                  aspectRatio: MediaQuery.of(context).size.height > 600
                      ? 390 / 600
                      : 350 / 455,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          onPrimary,
                          Color(0xFFE0E0E0),
                        ],
                      ),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final height = constraints.maxHeight;
                        final suggestIconHeight =
                            MediaQuery.of(context).size.height > 600
                                ? height * 14 / 250
                                : height * 14 / 275;

                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircleAvatar(
                                          child: Image.asset(
                                              'assets/images/icons/avatar.png'),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(user["full_name"],
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ],
                                    )
                                  ]),
                              SizedBox(
                                height: 15,
                              ),
                              TypeAheadField(
                                textFieldConfiguration: TextFieldConfiguration(
                                  autofocus: false,
                                  controller: _typeAheadController,
                                  decoration: InputDecoration(
                                    labelText:
                                        'Số điện thoại hoặc tên người nhận',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ),
                                suggestionsCallback: (pattern) async {
                                  return await getSuggestions(pattern);
                                },
                                itemBuilder: (context, suggestion) {
                                  Map<String, dynamic> userSuggestion =
                                      suggestion as Map<String, dynamic>;
                                  return ListTile(
                                    leading: Icon(Icons.account_circle),
                                    title: Text(userSuggestion["name"] ?? ''),
                                    subtitle:
                                        Text(userSuggestion["phone"] ?? ''),
                                  );
                                },
                                onSuggestionSelected: (suggestion) {
                                  Map<String, dynamic> userSuggestion =
                                      suggestion as Map<String, dynamic>;
                                  context
                                          .read<PaymentScreenBloc>()
                                          .phoneNumberInput =
                                      userSuggestion["phone"];
                                  _typeAheadController.text =
                                      userSuggestion["phone"];
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Nhập mệnh giá",
                                  prefixIcon:
                                      Icon(Icons.monetization_on_outlined),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buildSuggestButton(
                                      context, suggestIconHeight, '100.000'),
                                  buildSuggestButton(
                                      context, suggestIconHeight, '1.000.000'),
                                  buildSuggestButton(
                                      context, suggestIconHeight, '10.000.000')
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: messageController,
                                      onFieldSubmitted: (value) {
                                        context
                                            .read<PaymentScreenBloc>()
                                            .add(ChangeMessageEvent(value));
                                      },
                                      minLines: 5,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                        hoverColor: primaryContainer,
                                        focusColor: primary,
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 15),
                                        hintText: 'Bạn nhớ nhập lời nhắn nhé',
                                        prefixIcon: const Align(
                                            alignment: Alignment.topLeft,
                                            widthFactor: 1.0,
                                            heightFactor: 5.0,
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8.0, top: 10),
                                                child: Icon(Icons.message))),
                                        prefixIconConstraints:
                                            BoxConstraints(minWidth: 40),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildRoundButton(
                                      suggestIconHeight, 'Chuyển tiền', () {
                                    context
                                        .read<PaymentScreenBloc>()
                                        .add(ChangeMessageEvent('Chuyển tiền'));
                                  }),
                                  buildRoundButton(
                                      suggestIconHeight, 'Chúc zui', () {
                                    context
                                        .read<PaymentScreenBloc>()
                                        .add(ChangeMessageEvent('Chúc zui'));
                                  }),
                                  buildRoundButton(
                                      suggestIconHeight, 'Hết nợ hết nghĩa!',
                                      () {
                                    context.read<PaymentScreenBloc>().add(
                                        ChangeMessageEvent(
                                            'Hết nợ hết nghĩa!'));
                                  }),
                                ],
                              ),
                            ]);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    final height = constraints.maxHeight;

                    final themeButtonHeight = (height - 35) / 2;

                    return Column(
                      children: [
                        SizedBox(
                          height: themeButtonHeight,
                          child: AspectRatio(
                              aspectRatio: 270 / 48,
                              child: Container(
                                margin: const EdgeInsets.all(0),
                                decoration: const BoxDecoration(
                                    color: green,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: green, // Màu nền
                                    onPrimary: Colors.white, // Màu chữ
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(30),
                                        ),
                                      ),
                                      builder: (BuildContext context) {
                                        return PaymentConfirm(
                                          receiverPhoneNumber: phoneNumber,
                                          amount: amount,
                                          message: message,
                                        );
                                      },
                                    );
                                  },
                                  child: const Text(
                                    'Tiếp tục',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<List<Map<String, String>>> getSuggestions(String query) async {
    // Template data
    List<Map<String, String>> allUsers = [
      {"name": "Người dùng 1", "phone": "1234567890"},
      {"name": "Người dùng 2", "phone": "0987654321"},
      //...
    ];

    return allUsers.where((user) {
      final userLower = user["name"]?.toLowerCase() ?? '';
      final queryLower = query.toLowerCase();

      return userLower.contains(queryLower);
    }).toList();
  }

  Container buildSuggestButton(
      BuildContext context, double suggestIconHeight, String text) {
    text = '$textđ';
    return buildRoundButton(suggestIconHeight, text, () {
      context.read<PaymentScreenBloc>().add(ChangeAmountEvent(text));
    });
  }

  Container buildRoundButton(
      double suggestIconHeight, String text, void Function()? onTap) {
    return Container(
      height: suggestIconHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
              color: grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2)),
        ],
      ),
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Center(
          child: TextButton(
            onPressed: onTap,
            child: Text(text, style: const TextStyle(fontSize: 20)),
          ),
        ),
      ),
    );
  }
}
