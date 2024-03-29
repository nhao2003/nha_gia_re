import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color backgroundColor = fromHex("f4f4f4");
  static Color primaryColor = fromHex("FFB900");
  static Color red = fromHex("C71518");
  static Color green = fromHex("12A054");
  static Color secondary = fromHex("FFE9C2");
  static Color grey = fromHex("90959A");
  static Color blue = fromHex("00B4FF");
  static Color gery2 = grey;

  static MaterialColor customColor =const MaterialColor(
    0xFFFFB900,
    <int, Color>{
      50: Color(0xFFFFF4CC),
      100: Color(0xFFFFE89D),
      200: Color(0xFFFFDB6D),
      300: Color(0xFFFFCE3D),
      400: Color(0xFFFFC40D),
      500: Color(0xFFFFB900), // Set the main color to FFB900
      600: Color(0xFFCCA400),
      700: Color(0xFF997E00),
      800: Color(0xFF665900),
      900: Color(0xFF332400),
    },
  );


  static Color fromHex(String hexColorString) {
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
