// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'screen/payment/payment_screen.dart';
import 'style/color.dart';
import 'widgets/profile_widget.dart';

class SelectTransferPage extends StatefulWidget {
  const SelectTransferPage({Key? key}) : super(key: key);

  @override
  _SelectTransferPage createState() => _SelectTransferPage();
}

class _SelectTransferPage extends State<SelectTransferPage> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: onPrimary),
        backgroundColor: primary,
        title: Text(
          'Chuyển tiền',
          style: TextStyle(color: onPrimary),
        ),
      ),
      body: DefaultTabController(length: 3, child: getBody(context)),
    );
  }

  Widget getBody(BuildContext context) {
    return Center(
        child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width < 900
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width / 2,
                maxWidth: MediaQuery.of(context).size.width >= 900
                    ? MediaQuery.of(context).size.width / 2
                    : MediaQuery.of(context).size.width),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                      ProfileWidget(
                          icon: FontAwesomeIcons.wallet,
                          iconColor: black,
                          title: 'Đến bạn bè',
                          subtitle: "Chuyển đến SDT",
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: ((context) => PaymentScreen())),
                          )),
                      ProfileWidget(
                          icon: FontAwesomeIcons.creditCard,
                          iconColor: black,
                          title: 'Đến tài khoản ngân hàng',
                          subtitle: "Chuyển đến số tài khoản hoặc số thẻ",
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: ((context) => PaymentScreen())),
                          )),
                    ]),
                  ),
                ),
                Expanded(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 55,
                        padding: const EdgeInsets.all(10),
                        child: TabBar(
                            isScrollable: true,
                            unselectedLabelColor: Colors.black.withOpacity(0.3),
                            indicator: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    side:
                                    BorderSide(width: 2, color: primary))),
                            indicatorColor: primary,
                            labelColor: primary,
                            tabs: const [
                              Text(
                                "Gần đây",
                              ),
                              Text(
                                "Ví",
                              ),
                              Text(
                                "Ngân hàng",
                              ),
                            ]),
                      ),
                    ),
                    Expanded(
                        child: Center(
                          child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minWidth: MediaQuery.of(context).size.width < 900
                                      ? MediaQuery.of(context).size.width
                                      : MediaQuery.of(context).size.width / 2,
                                  maxWidth: MediaQuery.of(context).size.width >= 900
                                      ? MediaQuery.of(context).size.width / 2
                                      : MediaQuery.of(context).size.width),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 15),
                                child: Container(
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
                                  child: TabBarView(children: [
                                    everythingScreen(),
                                    everythingScreen(),
                                    everythingScreen(),
                                  ]),
                                ),
                              )),
                        )),
                    SizedBox(
                      height:
                      MediaQuery.of(context).size.height > 600 ? 100 : 50,
                    ),
                    Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(color: white, boxShadow: [
                                BoxShadow(
                                    color: grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2))
                              ]),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Text("Có thể bạn muốn thử:"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                height: 45,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                    color: white,
                                                    borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color:
                                                          grey.withOpacity(0.5),
                                                          spreadRadius: 2,
                                                          blurRadius: 5,
                                                          offset:
                                                          const Offset(0, 2))
                                                    ]),
                                                child: GestureDetector(
                                                    child: const Icon(
                                                      Icons.qr_code_2,
                                                      size: 35,
                                                    ),
                                                    onTap: () =>
                                                        Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: ((context) =>
                                                                  QRScreen(
                                                                      "QRSCANNER"))),
                                                        )),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.0),
                                                child: Text("QR Pay"),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 45,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                    color: white,
                                                    borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color:
                                                          grey.withOpacity(0.5),
                                                          spreadRadius: 2,
                                                          blurRadius: 5,
                                                          offset:
                                                          const Offset(0, 2))
                                                    ]),
                                                child: ImageIcon(AssetImage(
                                                    'assets/images/icons/sirenIcon.png')),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.0),
                                                child: Text("Nhắc chuyển tiền"),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ]),
                            )
                          ],
                        ))
                  ]),
                )
              ],
            )));
  }

  Widget everythingScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => PaymentScreen()))),
                    child: Column(
                      children: [
                        CircleAvatar(
                          child: Image.asset('assets/images/icons/avatar.png'),
                        ),
                        Text("Huy Trần")
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => PaymentScreen()))),
                    child: Column(
                      children: [
                        CircleAvatar(
                          child: Image.asset('assets/images/icons/avatar.png'),
                        ),
                        Text("Huy Trần")
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => PaymentScreen()))),
                    child: Column(
                      children: [
                        CircleAvatar(
                          child: Image.asset('assets/images/icons/avatar.png'),
                        ),
                        Text("Huy Trần")
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => PaymentScreen()))),
                    child: Column(
                      children: [
                        CircleAvatar(
                          child: Image.asset('assets/images/icons/avatar.png'),
                        ),
                        Text("Huy Trần")
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => PaymentScreen()))),
                    child: Column(
                      children: [
                        CircleAvatar(
                          child: Image.asset('assets/images/icons/avatar.png'),
                        ),
                        Text("Huy Trần")
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => PaymentScreen()))),
                    child: Column(
                      children: [
                        CircleAvatar(
                          child: Image.asset('assets/images/icons/avatar.png'),
                        ),
                        Text("Huy Trần")
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => PaymentScreen()))),
                    child: Column(
                      children: [
                        CircleAvatar(
                          child: Image.asset('assets/images/icons/avatar.png'),
                        ),
                        Text("Huy Trần")
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => PaymentScreen()))),
                    child: Column(
                      children: [
                        CircleAvatar(
                          child: Image.asset('assets/images/icons/avatar.png'),
                        ),
                        Text("Huy Trần")
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
