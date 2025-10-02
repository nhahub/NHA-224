import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xff242A32);
  static const Color secondary = Color(0xFF54A8E5);
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);
  static const Color lightGrey = Color(0xff8E8E92);
  static const Color darkGrey = Color(0xff3A3F47);
  static const Color orange = Color(0xffFFA235);
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