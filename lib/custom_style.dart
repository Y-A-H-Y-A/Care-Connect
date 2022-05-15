//*FONTS AND STYLES*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin CustomTextStyle {
  late double fontSize;
  late FontWeight fontWeight;
  // late TextDecoration decoration;
  //  Color color = Colors.white;

  static TextStyle style({
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
    TextDecoration decoration = TextDecoration.none,
  }) {
    return GoogleFonts.roboto(
        textStyle: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      decoration: decoration,
    ));
  }
}

//*COLORS*
mixin CustomColors {
  static const Color primaryDarkBlue = Color(0xFF1A496A);
  static const Color primaryNormalBlue = Color(0xFF39729A);
  static const Color primaryLightBlue = Color(0xFF5898C5);
}

//*ICONS*
class CustomIcons {
  CustomIcons._();

  static const _kFontFam = 'CustomIcons';
  static const String? _kFontPkg = null;

  // static const IconData chat_bubble =
  //     IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  // static const IconData chat_bubble_outlined =
  //     IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData paper_plane =
      IconData(0xe804, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  // static const IconData settings_gear =
  //     IconData(0xe805, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  // static const IconData settings_gear_outlined =
  //     IconData(0xe806, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData user_avatar =
      IconData(0xe807, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData add_new_user =
      IconData(0xe808, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData add_new_doctor =
      IconData(0xe809, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData arrow =
      IconData(0xe80a, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData care_connect_heart =
      IconData(0xe80b, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData care_connect_heart_outlined =
      IconData(0xe80c, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
