
import 'package:flutter/material.dart';

import '../../style/color.dart';
import '../app_navigator.dart';
import 'payment_confirm.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _controller = TextEditingController();
  final _msgController = TextEditingController();

  int _themeIndex = 0;

  Decoration _buildThemeDecoration() {
    switch (_themeIndex) {
      case 0:
        return BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              onPrimary,
              Color(0xFFE0E0E0),
            ],
          ),
        );
      case 1:
        return BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryContainer,
              primary,
            ],
          ),
        );
      default:
        return BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              onPrimary,
              Color(0xFFE0E0E0),
            ],
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: BackButton(color: onPrimary),
          backgroundColor: primary,
        ),
        body: Column(
          children: [
            AspectRatio(
              aspectRatio: MediaQuery.of(context).size.height > 600 ? 390 / 600 : 350/455,
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                //TODO: Add background image decoration
                decoration: _buildThemeDecoration(),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final height = constraints.maxHeight;

                    final suggestIconHeight = MediaQuery.of(context).size.height > 600 ? height * 14 / 250 : height * 14 / 275;

                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 26 / 5,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
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
                                    children: const [
                                      Text('Nguyễn Văn A',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      Text('Số dư: 900.000đ')
                                    ],
                                  )
                                ]),
                          ),
                          AspectRatio(
                            aspectRatio: 69 / 10,
                            child: TextFormField(
                              controller: _controller,
                              decoration: InputDecoration(
                                hoverColor: primaryContainer,
                                focusColor: primary,
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: const Icon(Icons.search),
                                border: UnderlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                hintText: "Nhập mệnh giá",
                                suffixIcon: IconButton(
                                  onPressed: _controller.clear,
                                  icon: const Icon(Icons.clear),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildSuggestButton(suggestIconHeight, '100.000'),
                              buildSuggestButton(
                                  suggestIconHeight, '1.000.000'),
                              buildSuggestButton(
                                  suggestIconHeight, '10.000.000')
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          AspectRatio(
                            aspectRatio: 344 / 35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _msgController,
                                    decoration: InputDecoration(
                                      hoverColor: primaryContainer,
                                      focusColor: primary,
                                      filled: true,
                                      fillColor: Colors.white,
                                      prefixIcon: const Icon(Icons.message),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      hintText: 'Bạn nhớ nhập lời nhắn nhé',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildRoundButton(suggestIconHeight, 'Chuyển tiền',
                                      () {
                                    _msgController.text = 'Chuyển tiền';
                                  }),
                              buildRoundButton(suggestIconHeight, 'Chúc zui',
                                      () {
                                    _msgController.text = 'Chúc zui';
                                  }),
                              buildRoundButton(
                                  suggestIconHeight, 'Hết nợ hết nghĩa!', () {
                                _msgController.text = 'Hết nợ hết nghĩa!';
                              })
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildThemeButton(Colors.grey.shade300, themeButtonHeight, Visibility(
                              visible: _themeIndex == 0,
                              child: const Icon(
                                Icons.check_circle_outline_rounded,
                                color: green,
                              )), () {
                            setState(() {
                              _themeIndex = 0;
                            });
                          }),
                          const SizedBox(width: 5),
                          buildThemeButton(Colors.blue, themeButtonHeight,
                              Visibility(
                                  visible: _themeIndex == 1,
                                  child: const Icon(
                                    Icons.check_circle_outline_rounded,
                                    color: green,
                                  )), () {
                                setState(() {
                                  _themeIndex = 1;
                                });
                              }),
                        ],
                      ),
                    ),
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
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(30))),
                                        builder: (BuildContext context) {
                                          return const PaymentConfirm(); //const PaymentConfirm();
                                        });
                                  },
                                  child: const Text(
                                    'Tiếp tục',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ),
                              ))),
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
      ),
    );
  }

  Widget buildThemeButton(
      Color color,
      double height,
      Widget child,
      void Function() onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: height,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: child
      ),
    );
  }

  Container buildSuggestButton(double suggestIconHeight, String text) {
    text = '$textđ';
    return buildRoundButton(suggestIconHeight, text, () {
      _controller.text = text;
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
