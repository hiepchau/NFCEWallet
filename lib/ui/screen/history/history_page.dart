// ignore_for_file: prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'package:nfc_e_wallet/data/model/transaction.dart';
import 'package:nfc_e_wallet/ui/screen/history/bloc/history_bloc.dart';

import '../../style/color.dart';
import 'history_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPage createState() => _HistoryPage();
}

class _HistoryPage extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryBloc()..add(InitHistoryEvent()),
      child: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          return DefaultTabController(
              length: 6,
              child: Scaffold(
                appBar: AppBar(
                  toolbarHeight: 130,
                  backgroundColor: primary,
                  automaticallyImplyLeading: false,
                  shadowColor: grey,
                  title: getAppBar(context),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(35),
                    child: getTabBar(),
                  ),
                ),
                body: getBody(context, state),
              ));
        },
      ),
    );
  }

  Widget getTabBar() {
    return Container(
        height: 48,
        decoration: const BoxDecoration(
            color: white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        child: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.black.withOpacity(0.3),
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 2, color: primary)),
            indicatorColor: primary,
            labelColor: primary,
            tabs: const [
              Text(
                "Tất cả",
              ),
              Text("Nạp tiền"),
              Text("Chuyển tiền"),
              Text("Nhận tiền"),
              Text("Điện thoại"),
              Text("Rút tiền"),
            ]));
  }

  Widget getAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 125,
      width: MediaQuery.of(context).size.width,
      child: Column(children: [
        Text(
          "Lịch sử",
          style: TextStyle(color: onPrimary),
        ),
        const SizedBox(height: 10),
        ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width < 900
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width / 2,
                maxWidth: MediaQuery.of(context).size.width >= 900
                    ? MediaQuery.of(context).size.width / 2
                    : MediaQuery.of(context).size.width),
            child: Row(children: [
              Expanded(
                  child: TextFormField(
                decoration: InputDecoration(
                  hoverColor: primaryContainer,
                  focusColor: primary,
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  hintText: "Tìm kiếm",
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              )),
              const SizedBox(
                width: 20,
              ),
            ]))
      ]),
    );
  }

  Widget getBody(BuildContext context, HistoryState state) {
    return Center(
      child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width < 900
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width / 2,
              maxWidth: MediaQuery.of(context).size.width >= 900
                  ? MediaQuery.of(context).size.width / 2
                  : MediaQuery.of(context).size.width),
          child: TabBarView(children: [
            everythingHistoryScreen(context, state),
            depositHistoryScreen(context, state),
            transferistoryScreen(context, state),
            receiveHistoryScreen(context, state),
            mobileHistoryScreen(context, state),
            withdrawHistoryScreen(context, state),
          ])),
    );
  }

  Widget everythingHistoryScreen(BuildContext context, HistoryState state) {
    bool isNull = true;
    List<Widget> listWidget = List<Widget>.empty(growable: true);
    List<Transaction> listTransaction = List.from(state.listTransactions);
    listTransaction.sort(((a, b) {
      DateTime dateA = DateTime.parse(a.time!);
      DateTime dateB = DateTime.parse(b.time!);
      return dateB.compareTo(dateA);
    }));
    int temp = 0;
    for (Transaction transaction in listTransaction) {
      if (DateTime.parse(transaction.time!).month != temp) {
        isNull = false;
        temp = DateTime.parse(transaction.time!).month;
        listWidget.add(Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Tháng $temp",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 900
                      ? 30
                      : MediaQuery.of(context).size.width > 350
                          ? 25
                          : 20,
                  color: primary,
                  fontFamily: 'SVN-Gotham',
                  fontWeight: FontWeight.w700),
            )));
      }
      if (transaction.type == "RECEIVE") {
        isNull=false;
        listWidget.add(buildReceiveWidget(transaction));
      }
      if (transaction.type == "TRANSFER") {
        isNull=false;
        listWidget.add(buildTransferWidget(transaction));
      }
      if (transaction.type == "WITHDRAW") {
        isNull=false;
        listWidget.add(buildWithdrawWidget(transaction));
      }
      if (transaction.type == "PHONE") {
        isNull=false;
        listWidget.add(buildPhoneWidget(transaction));
      }
      if (transaction.type == "DEPOSIT") {
        isNull=false;
        listWidget.add(buildDepositWidget(transaction));
      }
    }
    if(isNull){
      listWidget=buildNoTransactionWidget(listWidget);
    }
    return ListView(
      padding: const EdgeInsets.all(5),
      children: listWidget,
    );
  }

  Widget depositHistoryScreen(BuildContext context, HistoryState state) {
    bool isNull = true;
    List<Widget> listWidget = List<Widget>.empty(growable: true);
    List<Transaction> listTransaction = List.from(state.listTransactions);
    listTransaction.sort(((a, b) {
      DateTime dateA = DateTime.parse(a.time!);
      DateTime dateB = DateTime.parse(b.time!);
      return dateB.compareTo(dateA);
    }));
    int temp = 0;
    for (var transaction in listTransaction) {
      if (DateTime.parse(transaction.time!).month != temp) {
        temp = DateTime.parse(transaction.time!).month;
        listWidget.add(Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Tháng $temp",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 900
                      ? 30
                      : MediaQuery.of(context).size.width > 350
                          ? 25
                          : 20,
                  color: primary,
                  fontFamily: 'SVN-Gotham',
                  fontWeight: FontWeight.w700),
            )));
      }
      if (transaction.type == "DEPOSIT") {
        isNull = false;
        listWidget.add(buildDepositWidget(transaction));
      }
    }
    if (isNull == true) {
      listWidget = buildNoTransactionWidget(listWidget);
    }
    return ListView(
      padding: const EdgeInsets.all(5),
      children: listWidget,
    );
  }

  Widget transferistoryScreen(BuildContext context, HistoryState state) {
    bool isNull = true;
    List<Transaction> listTransaction = List.from(state.listTransactions);
    listTransaction.sort(((a, b) {
      DateTime dateA = DateTime.parse(a.time!);
      DateTime dateB = DateTime.parse(b.time!);
      return dateB.compareTo(dateA);
    }));
    int temp = 0;
    List<Widget> listWidget = List<Widget>.empty(growable: true);
    for (var transaction in listTransaction) {
      if (DateTime.parse(transaction.time!).month != temp) {
        temp = DateTime.parse(transaction.time!).month;
        listWidget.add(Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Tháng $temp",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 900
                      ? 30
                      : MediaQuery.of(context).size.width > 350
                          ? 25
                          : 20,
                  color: primary,
                  fontFamily: 'SVN-Gotham',
                  fontWeight: FontWeight.w700),
            )));
      }
      if (transaction.type == "TRANSFER") {
        isNull = false;
        listWidget.add(buildTransferWidget(transaction));
      }
    }
    if(isNull){
      listWidget = buildNoTransactionWidget(listWidget);
    }
    return ListView(
      padding: const EdgeInsets.all(5),
      children: listWidget,
    );
  }

  Widget receiveHistoryScreen(BuildContext context, HistoryState state) {
    bool isNull = true;
    List<Transaction> listTransaction = List.from(state.listTransactions);

    listTransaction.sort(((a, b) {
      DateTime dateA = DateTime.parse(a.time!);
      DateTime dateB = DateTime.parse(b.time!);
      return dateB.compareTo(dateA);
    }));
    int temp = 0;
    List<Widget> listWidget = List<Widget>.empty(growable: true);
    for (var transaction in listTransaction) {
      if (DateTime.parse(transaction.time!).month != temp) {
        temp = DateTime.parse(transaction.time!).month;
        listWidget.add(Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Tháng $temp",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 900
                      ? 30
                      : MediaQuery.of(context).size.width > 350
                          ? 25
                          : 20,
                  color: primary,
                  fontFamily: 'SVN-Gotham',
                  fontWeight: FontWeight.w700),
            )));
      }
      if (transaction.type == "RECEIVE") {
        isNull = false;
        listWidget.add(buildReceiveWidget(transaction));
      }
    }
    if(isNull){
      listWidget=buildNoTransactionWidget(listWidget);
    }
    return ListView(
      padding: const EdgeInsets.all(5),
      children: listWidget,
    );
  }

  Widget mobileHistoryScreen(BuildContext context, HistoryState state) {
    bool isNull = true;
    List<Transaction> listTransaction = List.from(state.listTransactions);

    listTransaction.sort(((a, b) {
      DateTime dateA = DateTime.parse(a.time!);
      DateTime dateB = DateTime.parse(b.time!);
      return dateB.compareTo(dateA);
    }));
    int temp = 0;
    List<Widget> listWidget = List<Widget>.empty(growable: true);
    for (var transaction in listTransaction) {
      if (DateTime.parse(transaction.time!).month != temp) {
        temp = DateTime.parse(transaction.time!).month;
        listWidget.add(Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Tháng $temp",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 900
                      ? 30
                      : MediaQuery.of(context).size.width > 350
                          ? 25
                          : 20,
                  color: primary,
                  fontFamily: 'SVN-Gotham',
                  fontWeight: FontWeight.w700),
            )));
      }
      if (transaction.type == "PHONE") {
        isNull = false;
        listWidget.add(buildPhoneWidget(transaction));
      }
    }
    if(isNull){
      listWidget=buildNoTransactionWidget(listWidget);
    }
    return ListView(
      padding: const EdgeInsets.all(5),
      children: listWidget,
    );
  }

  Widget withdrawHistoryScreen(BuildContext context, HistoryState state) {
    bool isNull = true;
    List<Transaction> listTransaction = List.from(state.listTransactions);

    listTransaction.sort(((a, b) {
      DateTime dateA = DateTime.parse(a.time!);
      DateTime dateB = DateTime.parse(b.time!);
      return dateB.compareTo(dateA);
    }));
    int temp = 0;
    List<Widget> listWidget = List<Widget>.empty(growable: true);
    for (var transaction in listTransaction) {
      if (DateTime.parse(transaction.time!).month != temp) {
        temp = DateTime.parse(transaction.time!).month;
        listWidget.add(Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Tháng $temp",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 900
                      ? 30
                      : MediaQuery.of(context).size.width > 350
                          ? 25
                          : 20,
                  color: primary,
                  fontFamily: 'SVN-Gotham',
                  fontWeight: FontWeight.w700),
            )));
      }
      if (transaction.type == "WITHDRAW") {
        isNull = false;
        listWidget.add(buildWithdrawWidget(transaction));
      }
    }
    if(isNull){
      listWidget = buildNoTransactionWidget(listWidget);
    }
    return ListView(
      padding: const EdgeInsets.all(5),
      children: listWidget,
    );
  }

  Widget buildTransferWidget(Transaction transaction){
    return HistoryWidget(
            transaction: transaction,
            icon: FontAwesomeIcons.moneyBillTransfer,
            iconColor: Colors.green,
            title: "Chuyển tiền",
            subtitle: "Chuyển tiền đến " + transaction.to_User,
            time: transaction.time!,
            amount: "-" + transaction.amount.toString());
  }

  Widget buildWithdrawWidget(Transaction transaction) {
    return HistoryWidget(
            transaction: transaction,
            icon: Icons.account_balance_wallet_rounded,
            iconColor: Colors.redAccent,
            title: "Rút tiền",
            subtitle: "Rút tiền về " + transaction.to_User,
            time: transaction.time!,
            amount: "-" + transaction.amount.toString());
  }

  Widget buildDepositWidget(Transaction transaction) {
    return HistoryWidget(
            transaction: transaction,
            icon: Icons.monetization_on_outlined,
            iconColor: Colors.green,
            title: "Nạp tiền",
            subtitle: "Nạp tiền từ " + transaction.to_User,
            time: transaction.time!,
            amount: "+" + transaction.amount.toString());
  }

  Widget buildPhoneWidget(Transaction transaction) {
    return HistoryWidget(
        transaction: transaction,
        icon: Icons.phone_android,
        iconColor: Colors.blueAccent,
        title: "Nạp tiền điện thoại",
        subtitle: "Nạp cho số " + transaction.to_User,
        time: transaction.time!,
        amount: "-" + transaction.amount.toString());
  }

  Widget buildReceiveWidget(Transaction transaction) {
    return HistoryWidget(
        transaction: transaction,
        icon: Icons.arrow_downward_rounded,
        iconColor: Colors.green,
        title: "Nhận tiền",
        subtitle: "Nhận tiền từ " + transaction.from_User,
        time: transaction.time!,
        amount: "+" + transaction.amount.toString());
  }

  List<Widget> buildNoTransactionWidget(List<Widget> listWidget) {
    listWidget.clear();
    listWidget.add(
      Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 3,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage("assets/images/icons/cantfind.png"))),
          ),
          Text(
            "Bạn không có giao dịch nào cả.",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width > 900
                  ? 15
                  : MediaQuery.of(context).size.width > 350
                      ? 15
                      : 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
    return listWidget;
  }

  String formatDate(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('HH:mm dd/MM/yyyy');
    var outputDate =
        outputFormat.format(inputDate.add(const Duration(hours: 7)));
    return outputDate;
  }
}
