import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_text_style.dart';

class AppTheme {
  static final themeData = ThemeData(
    primaryColor: AppColor.primary,
    accentColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      textTheme: AppTextStyle.textTheme.apply(bodyColor: AppColor.text),
      iconTheme: IconThemeData(color: AppColor.text),
      actionsIconTheme: IconThemeData(color: Colors.black45),
      brightness: Brightness.dark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.black12),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.black12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.black12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.black12),
      ),
      focusColor: Colors.black12,
      fillColor: Colors.black12,
      isDense: true,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: AppTextStyle.textTheme,
  );
}
