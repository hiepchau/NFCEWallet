import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nfc_e_wallet/ui/style/color.dart';

class ShortcutIcon extends StatelessWidget {
  final Widget icon;
  final String text;
  final double iconSize;
  final double maxSize;
  final bool shadow;
  final void Function()? onTap;

  const ShortcutIcon(this.icon, this.text, this.iconSize, this.maxSize,
      {Key? key, this.shadow = true, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: maxSize,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                color: onPrimary,
                borderRadius: BorderRadius.circular(10),
                boxShadow: (() {
                  if (!shadow) {
                    return <BoxShadow>[];
                  }
                  return [
                    const BoxShadow(
                      color: Colors.black45,
                      blurRadius: 15,
                      offset: Offset(0, 6),
                    )
                  ];
                })(),
              ),
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: FittedBox(
                    child: icon),
              ),
            ),
            const SizedBox(height: 5),
            Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primary,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                )),
          ],
        ),
      ),
    );
  }
}
