// import 'package:flutter/cupertino.dart';

// abstract class AppColors {
//   static const Color primary = Color(0xff242A32);
//   static const Color secondary = Color(0xFF54A8E5);
//   static const Color white = Color(0xffffffff);
//   static const Color black = Color(0xff000000);
//   static const Color lightGrey = Color(0xff8E8E92);
//   static const Color darkGrey = Color(0xff3A3F47);
//   static const Color orange = Color(0xffFFA235);
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppColors {
  // 🌞 Light Theme Colors
  static const Color lightPrimary = Color.fromRGBO(142, 108, 239, 1);
  static const Color lightSecondary = Color.fromRGBO(244, 244, 244, 1);
  static const Color lightBackground = Color.fromRGBO(255, 255, 255, 1);

  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF000000);
  static const Color lightTextSecondary = Color(0xFF8E8E92);

  // 🌙 Dark Theme Colors
  static const Color darkPrimary = Color.fromRGBO(142, 108, 239, 1);
  static const Color darkSecondary = Color.fromRGBO(52, 47, 63, 1);
  static const Color darkBackground = Color.fromRGBO(29, 24, 42, 1);

  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFF8E8E92);

  // 🌐 Common Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color orange = Color(0xFFFFA235);
}


ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    secondary: Color(0xffF4F4F4),
    primary: Color(0xff8E6CEF),
  )
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Color(0xff1D182A),
    secondary: Color(0xff342F3F),
    primary: Color(0xff8E6CEF),

  )

);