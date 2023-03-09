import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

final Color primary = ColorScheme.fromSeed(seedColor: Colors.blue).primary;
final Color onPrimary = ColorScheme.fromSeed(seedColor: Colors.blue).onPrimary;
final Color secondary = ColorScheme.fromSeed(seedColor: Colors.blue).secondary;
final Color primaryContainer =
    ColorScheme.fromSeed(seedColor: Colors.blue).primaryContainer;
final Color onPrimaryContainer =
    ColorScheme.fromSeed(seedColor: Colors.blue).onPrimaryContainer;
final Color outline = ColorScheme.fromSeed(seedColor: Colors.blue).outline;
final Color secondaryContainer =
    ColorScheme.fromSeed(seedColor: Colors.blue).secondaryContainer;
final Color surfaceVariant =
    ColorScheme.fromSeed(seedColor: Colors.blue).surfaceVariant;
const Color white = Color(0xFFFFFFFF);
const Color black = Color(0xFF000000);
const Color grey = Color(0xFF8e8e93);
const Color orange = Color(0xFFFF8647);
const Color blue = Color(0xFF2094FF);
const Color yellow = Color(0xFFFED200);
const Color neon = Color(0xFF0FFdc1);
const Color red = Color(0xFFff3b30);
const Color green = Color.fromRGBO(4, 201, 121, 1);
const Color teal = Color(0xFF009688);
const Color purple = Color(0xFF9c27b0);
const Color deepPurple = Color(0xFF673ab7);

class CustomTheme {
  const CustomTheme();

  static final Color loginGradientStart = primary;
  static const Color loginGradientEnd = green;
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static final LinearGradient primaryGradient = LinearGradient(
    colors: <Color>[loginGradientStart, loginGradientEnd],
    stops: <double>[0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
