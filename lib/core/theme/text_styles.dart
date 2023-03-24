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
}
