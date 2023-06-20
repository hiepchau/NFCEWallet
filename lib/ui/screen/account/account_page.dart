import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_e_wallet/ui/screen/authenticate/login/authenticate_bloc.dart';
import 'package:nfc_e_wallet/ui/screen/wallet/bloc/wallet_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../style/color.dart';
import '../../style/constants.dart';
import '../../widgets/profile_widget.dart';
import '../authenticate/login/login_page.dart';
import 'account_page_bloc.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<AccountPageBloc>(
            create: (context) => AccountPageBloc(),
          ),
          BlocProvider<WalletBloc>(
            create: (context) => WalletBloc(),
          ),
        ],
        child: AccountScreen(),
      ),
    );
  }
}

class AccountScreen extends StatefulWidget {
  @override
  _AccountPage createState() => _AccountPage();
}

class _AccountPage extends State<AccountScreen> {
  bool isVisible = false;

  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    final accountBloc = BlocProvider.of<AccountPageBloc>(context);
    final walletBloc = BlocProvider.of<WalletBloc>(context);
    return BlocBuilder<AccountPageBloc, AccountPageState>(
      bloc: accountBloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primary,
            title: Text(
              'Tài khoản',
              style: TextStyle(color: onPrimary),
            ),
            automaticallyImplyLeading: false,
          ),
          body: getBody(context, walletBloc),
        );
      },
    );
  }

  Widget getBody(BuildContext context, WalletBloc walletBloc) {
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
                child: getAccountSection(context, walletBloc),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getAccountSection(BuildContext context, WalletBloc wallet) {
    final isVisible = ValueNotifier(false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: white,
                boxShadow: [
                  BoxShadow(
                      color: grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2)),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 45,
                      height: 45,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://www.woolha.com/media/2020/03/eevee.png"),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Hiệp Châu",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              )),
                          const Text(
                            "0999000999",
                            style: wGreyTextStyle,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 25,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: green),
                            child: Text(
                              "Đã xác thực",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: onPrimary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Quản lí ví",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 900
                    ? 18
                    : MediaQuery.of(context).size.width > 350
                        ? 16
                        : 13,
                fontWeight: FontWeight.w700,
                color: primary),
          ),
          const SizedBox(
            height: 10,
          ),
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
            child: BlocBuilder<WalletBloc, WalletState>(
              bloc: wallet,
              builder: (context, state) {
                return Column(children: [
                  Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        onExpansionChanged: (temp) {
                          isVisible.value = temp;
                        },
                        childrenPadding: const EdgeInsets.all(5),
                        title: const Text("Tài khoản/Ví"),
                        children: state is WalletInitialState
                            ? _buildExpandableContent(state.listWallet)
                            : _buildNoWallet(),
                      )),
                  Visibility(
                    visible: isVisible.value,
                    child: Text(
                      "Xem tất cả (3)",
                      style: TextStyle(color: primary),
                    ),
                  ),
                  ProfileWidget(
                    icon: Icons.receipt_long,
                    iconColor: Colors.yellow,
                    title: 'Quản lý thanh toán',
                    subtitle: "",
                    onTap: () {},
                  ),
                  ProfileWidget(
                    icon: Icons.shield,
                    iconColor: Colors.green,
                    title: 'Bảo mật',
                    subtitle: "",
                    onTap: () {},
                  ),
                ]);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Khác",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 900
                    ? 18
                    : MediaQuery.of(context).size.width > 350
                        ? 16
                        : 13,
                fontWeight: FontWeight.w700,
                color: primary),
          ),
          const SizedBox(
            height: 10,
          ),
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
              ProfileWidget(
                icon: Icons.settings,
                iconColor: Colors.grey,
                title: 'Cài đặt ứng dụng',
                subtitle: "",
                onTap: () {},
              ),
              ProfileWidget(
                icon: Icons.headset_mic,
                iconColor: Colors.green,
                title: 'Trung tâm trợ giúp',
                subtitle: "",
                onTap: () {},
              ),
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              context.read<AccountPageBloc>().add(LogoutEvent());
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (_) => false);
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: red,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 2))
                    ]),
                child: Text(
                  "ĐĂNG XUẤT",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: MediaQuery.of(context).size.width > 900
                          ? 18
                          : MediaQuery.of(context).size.width > 350
                              ? 16
                              : 13,
                      color: onPrimary),
                )),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildNoWallet() {
    List<Widget> columnContent = [];
    return columnContent;
  }

  // ignore: non_constant_identifier_names
  List<Widget> _buildExpandableContent(List? wallet_lists) {
    List<Widget> columnContent = [];

    for (var content in wallet_lists!) {
      if (content["name"] == "TPBank") {
        columnContent.add(
          ListTile(
            title: Text(
              content["name"],
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 900
                    ? 15
                    : MediaQuery.of(context).size.width > 350
                        ? 15
                        : 13,
              ),
            ),
            trailing: Text(
              content["card_Number"],
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 900
                    ? 15
                    : MediaQuery.of(context).size.width > 350
                        ? 15
                        : 13,
              ),
            ),
            leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'assets/images/icons/tpbankIcon.png',
                  width: 25,
                  height: 25,
                )),
          ),
        );
      }
      if (content["name"] == "VietcomBank") {
        columnContent.add(
          ListTile(
            title: Text(
              content["name"],
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 900
                    ? 15
                    : MediaQuery.of(context).size.width > 350
                        ? 15
                        : 13,
              ),
            ),
            trailing: Text(
              content["card_Number"],
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 900
                    ? 15
                    : MediaQuery.of(context).size.width > 350
                        ? 15
                        : 13,
              ),
            ),
            leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'assets/images/icons/vietcombankIcon.png',
                  width: 25,
                  height: 25,
                )),
          ),
        );
      }
      if (content["name"] == "Ví") {
        columnContent.add(
          ListTile(
            title: Text(
              content["name"],
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 900
                    ? 15
                    : MediaQuery.of(context).size.width > 350
                        ? 15
                        : 13,
              ),
            ),
            trailing: Text(
              content["balance"],
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 900
                    ? 15
                    : MediaQuery.of(context).size.width > 350
                        ? 15
                        : 13,
              ),
            ),
            leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'assets/images/icons/blackWalletIcon.png',
                )),
          ),
        );
      }
    }
    return columnContent;
  }
}
