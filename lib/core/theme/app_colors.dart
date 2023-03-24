import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color backgroundColor = _fromHex("f4f4f4");
  static Color primaryColor = _fromHex("FFB900");
  static Color red = _fromHex("C71518");
  static Color green = _fromHex("12A054");
  static Color secondary = _fromHex("FFE9C2");
  static Color grey = _fromHex("90959A");
  static Color blue = _fromHex("00B4FF");

  static Color _fromHex(String hexColorString) {
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}