import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyle extends TextStyle {
  static TextStyle logo(Color color) {
    return GoogleFonts.workSans(
      fontSize: 35,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }
  static TextStyle login(Color color)
  {
    return GoogleFonts.roboto(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }
}
