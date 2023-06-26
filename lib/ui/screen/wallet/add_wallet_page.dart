import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:nfc_e_wallet/main.dart';
import 'package:nfc_e_wallet/ui/screen/security/bloc/security_bloc.dart';
import '../../style/color.dart';

class AddBankScreen extends StatefulWidget {
  @override
  AddBankScreenState createState() => AddBankScreenState();
}

class AddBankScreenState extends State<AddBankScreen> {
  bool isVisible = false;
  final TextEditingController bankController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController fullnameController =
      TextEditingController(text: user.full_name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(
          'Liên kết ngân hàng',
          style: TextStyle(color: onPrimary),
        ),
        leading: BackButton(color: onPrimary),
      ),
      body: BlocProvider(
        create: (context) => SecurityBloc(isAuthByFingerprint, isNFCEnable),
        child: Column(
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
                    child: BlocBuilder<SecurityBloc, SecurityState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(children: [
                                Expanded(child: Text("Thông tin liên kết")),
                                Text(
                                  "Điều kiện liên kết",
                                  style: TextStyle(color: green),
                                )
                              ]),
                              const SizedBox(height: 15,),
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 2))
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 15),
                                    child: Column(children: [
                                      TypeAheadField(
                                        textFieldConfiguration:
                                            TextFieldConfiguration(
                                          onSubmitted: (value) {
                                            bankController.text = value;
                                          },
                                          autofocus: false,
                                          controller: bankController,
                                          decoration: InputDecoration(
                                            labelText:
                                                'Nhập ngân hàng để liên kết',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                          ),
                                        ),
                                        suggestionsCallback: (pattern) async {
                                          return await getSuggestions(pattern);
                                        },
                                        itemBuilder: (context, suggestion) {
                                          Map<String, dynamic> bankSuggestion =
                                              suggestion as Map<String, dynamic>;
                                          return ListTile(
                                            leading: Icon(
                                                Icons.account_balance_rounded),
                                            title: Text(
                                                bankSuggestion["bank"] ?? ''),
                                          );
                                        },
                                        onSuggestionSelected: (suggestion) {
                                          Map<String, dynamic> bankSuggestion =
                                              suggestion as Map<String, dynamic>;
                                          setState(() {
                                            bankController.text =
                                                bankSuggestion["bank"];
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      TextField(
                                        style: TextStyle(color: grey),
                                        controller: fullnameController,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          labelText: 'Họ tên trên thẻ',
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 15),
                                          prefixIcon:
                                              Icon(Icons.account_circle_rounded),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      TextField(
                                        controller: cardNumberController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hoverColor: primaryContainer,
                                          labelText: 'Số thẻ',
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 15),
                                          prefixIcon:
                                              Icon(Icons.account_circle_rounded),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  )),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<Map<String, String>>> getSuggestions(String query) async {
  // Template data
  List<Map<String, String>> allBanks = [
    {"bank": "TPbank"},
    {"bank": "Vietcombank"},
    {"bank": "Techcombank"},
    {"bank": "MB"},
    {"bank": "BIDV"},
  ];

  return allBanks.where((bank) {
    final bankLower = bank["bank"]?.toLowerCase() ?? '';
    final queryLower = query.toLowerCase();

    return bankLower.contains(queryLower);
  }).toList();
}
