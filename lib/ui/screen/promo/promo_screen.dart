import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nfc_e_wallet/ui/screen/promo/promo_item.dart';
import 'package:nfc_e_wallet/ui/style/color.dart';
import 'package:nfc_e_wallet/utils/list_utils.dart';
import 'package:nfc_e_wallet/utils/widget_utils.dart';

class Promo {
  final String title;
  final String subTitle;
  final String description;
  final String price;
  final String actionTitle;

  Promo(this.title, this.subTitle, this.description, this.price,
      this.actionTitle);

  static List<Promo> generateRandomPromos(int count) {
    final random = Random();
    final titles = [
      'Baemin',
      'Grab',
      'Shopee',
      'Tiki',
      'Lazada',
      'Zalora',
      'Traveloka',
      'Gojek',
      'Tokopedia',
      'Bukalapak'
    ];
    final subTitles = [
      'Giảm 10.000đ',
      'Giảm 20.000đ',
      'Giảm 30.000đ',
      'Giảm 10%',
    ];
    final descriptions = [
      'Cho đơn từ 50.000đ',
      'Cho đơn từ 100.000đ',
      'Cho đơn từ 150.000đ',
      'Cho đơn có sản phầm từ 200.000đ',
    ];
    final prices = [
      '2 xu',
      '3 xu',
      '4 xu',
      '5 xu',
    ];
    final actionTitles = ['Đổi ngay'];
    final result = <Promo>[];
    for (int i = 0; i < count; i++) {
      final title = titles[random.nextInt(titles.length)];
      final subTitle = subTitles[random.nextInt(subTitles.length)];
      final description = descriptions[random.nextInt(descriptions.length)];
      final price = prices[random.nextInt(prices.length)];
      final actionTitle = actionTitles[random.nextInt(actionTitles.length)];
      result.add(Promo(title, subTitle, description, price, actionTitle));
    }
    return result;
  }

  Widget toWidget() {
    return PromoItem(
      title: title,
      subTitle: subTitle,
      description: description,
      price: price,
      actionTitle: actionTitle,
    );
  }
}

class _PromoTab extends StatefulWidget {
  const _PromoTab({Key? key}) : super(key: key);

  @override
  State<_PromoTab> createState() => _PromoTabState();
}

class _PromoTabState extends State<_PromoTab> {
  final List<List<Promo>> _hotPromos = [
    Promo.generateRandomPromos(4),
    Promo.generateRandomPromos(6),
    Promo.generateRandomPromos(3),
  ];
  int _promoIndex = 0;

  final _hotDealPromo = Promo.generateRandomPromos(4);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        final promoItemWidth = width * 150 / 390;
        final buttonHeight = height * 28 / 720;

        final promoRows = WidgetUtils.rowEvenlyWidthDivideWrap(
            width,
            promoItemWidth,
            2,
            _hotDealPromo
                .map((e) =>
                SizedBox(width: promoItemWidth, child: e.toWidget()))
                .toList())
            .map((e) => Row(children: e))
            .toList();

        return ListView(
          shrinkWrap: false,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:15.0),
              child: Row(
                children: const [
                  Icon(
                    FontAwesomeIcons.fire,
                    color: Color.fromRGBO(252, 82, 44, 1),
                  ),
                  Text(
                    'Deal \'hời\' chỉ từ 2 xu',
                    style: TextStyle(color: Color.fromRGBO(237, 105, 74, 1), fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Column(
                children: ListUtils.join(
                    promoRows, (_) => const SizedBox(height: 10))),
            SizedBox(height: 10,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text('Khám phá quà mới',style: TextStyle(fontSize: 18),),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildRoundButton(buttonHeight, 'Tất cả', () {
                  setState(() {
                    _promoIndex = 0;
                  });
                }),
                buildRoundButton(buttonHeight, 'Mua sắm', () {
                  setState(() {
                    _promoIndex = 1;
                  });
                }),
                buildRoundButton(buttonHeight, 'Điện thoại', () {
                  setState(() {
                    _promoIndex = 2;
                  });
                }),
              ],
            ),
            SizedBox(height: 10,),

            Column(
                children: ListUtils.join(
                    WidgetUtils.rowEvenlyWidthDivideWrap(
                        width,
                        promoItemWidth,
                        2,
                        _hotPromos[_promoIndex]
                            .map((e) => SizedBox(
                            width: promoItemWidth, child: e.toWidget()))
                            .toList())
                        .map((e) => Row(children: e))
                        .toList(),
                        (_) => const SizedBox(height: 10))),
            SizedBox(height: 30,),
          ],
        );
      },
    );
  }

  Widget buildRoundButton(
      double suggestIconHeight, String text, void Function()? onTap) {
    return Container(
      width: 100.w,
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
            child: Text(text, style: TextStyle(fontSize: 30.sp)),
          ),
        ),
      ),
    );
  }
}

class PromoScreen extends StatefulWidget {
  const PromoScreen({Key? key}) : super(key: key);

  @override
  State<PromoScreen> createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        title: Text(
          'Khuyến mãi',
          style: TextStyle(color: onPrimary, fontSize: 18),
        ),
      ),
      body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      flex: 53,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final width = constraints.maxWidth;

                          // final iconWidth = width * 25 / 390;
                          // final contentWidth = width * 100 / 390;
                          final iconWidth = 25.0.w;
                          final contentWidth = 100.0.w;

                          final fontSize = 10.0.sp;

                          return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                decorateFlexButton(
                                    iconWidth,
                                    fontSize,
                                    contentWidth,
                                    FontAwesomeIcons.coins,
                                    Colors.amber,
                                    '100.000',
                                    onPrimary, () {
                                  setState(() {
                                    _tabController.index = 0;
                                  });
                                }),
                                SizedBox(width: 10,),
                                decorateFlexButton(
                                    iconWidth,
                                    fontSize,
                                    contentWidth,
                                    FontAwesomeIcons.gifts,
                                    green,
                                    'Quà của tôi',
                                    onPrimary, () {
                                  setState(() {
                                    _tabController.index = 1;
                                  });
                                })
                              ]);
                        },
                      )),
                  Expanded(
                      flex: 670,
                      child: TabBarView(
                          controller: _tabController,
                          children: const [_PromoTab(), _PromoTab()])),
                ],
              )
            ],
          )),
    );
  }

  Widget decorateFlexButton(
      double iconWidth,
      double fontSize,
      double contentWidth,
      IconData icon,
      Color iconColor,
      String text,
      Color color,
      void Function()? onTap) {
    return buildFlexButton(
        Icon(
          icon,
          color: iconColor,
          size: MediaQuery.of(context).size.width > 350 ? 35 : 20,
        ),
        iconWidth,
        Container(
            height: iconWidth * 1.2,
            decoration: BoxDecoration(
                border: Border.all(color: primary),
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                color: color),
            child: Center(
              child: Text(text,
                  style:
                  TextStyle(fontSize: fontSize, color: primary)),
            )),
        contentWidth,
        onTap);
  }

  Widget buildFlexButton(Widget flex, double flexWidth, Widget content,
      double contentWidth, void Function()? onTap) {
    double flexOver = flexWidth * 0.5;
    double flexRemain = flexWidth - flexOver;
    return SizedBox(
      width: flexRemain + contentWidth,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: flexRemain),
                child: SizedBox(
                  width: contentWidth,
                  child: content,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: flexWidth,
                child: FittedBox(child: flex),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
