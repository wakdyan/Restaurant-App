import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class AppTextStyle {
  static final textTheme = TextTheme(
    headline1: GoogleFonts.roboto(
      fontSize: 96,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      color: AppColor.text,
    ),
    headline2: GoogleFonts.roboto(
      fontSize: 60,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      color: AppColor.text,
    ),
    headline3: GoogleFonts.roboto(
      fontSize: 48,
      fontWeight: FontWeight.w400,
      color: AppColor.text,
    ),
    headline4: GoogleFonts.roboto(
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: AppColor.text,
    ),
    headline5: GoogleFonts.roboto(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: AppColor.text,
    ),
    headline6: GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: AppColor.text,
    ),
    subtitle1: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: AppColor.text,
    ),
    subtitle2: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: AppColor.text,
    ),
    bodyText1: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: AppColor.text,
    ),
    bodyText2: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: AppColor.text,
    ),
    button: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
      color: Colors.white,
    ),
    caption: GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: AppColor.caption,
    ),
    overline: GoogleFonts.roboto(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: AppColor.text,
    ),
  );

  static final bold = TextStyle(fontWeight: FontWeight.bold);
}
