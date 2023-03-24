import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const MaterialColor baseColor = Colors.green;
  static const MaterialColor customColor = MaterialColor(
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

  static const Color normal = Color(0xFF559360);
}
