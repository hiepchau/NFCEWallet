import 'package:flutter/material.dart';

class ShortcutIcon extends StatelessWidget {
  final AssetImage asset;
  final String text;
  final double iconSize;
  final double maxSize;
  final bool shadow;
  final void Function()? onTap;

  const ShortcutIcon(this.asset, this.text, this.iconSize, this.maxSize,
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
                color: Colors.white,
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
              child: Image(image: asset),
            ),
            const SizedBox(height: 5),
            Text(text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                )),
          ],
        ),
      ),
    );
  }
}