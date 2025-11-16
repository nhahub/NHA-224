import 'package:flutter/material.dart';
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


abstract class AppColors {
  // 🌞 Light Theme Colors
  static const Color lightPrimary = Color(0xFF7C3AED); // Purple
  static const Color lightSecondary = Color(0xFFF5F5F5); // Light grey
  static const Color lightBackground = Color(0xFFFAFAFA); // Off-white
  static const Color lightCardBackground = Color(0xFFFFFFFF); // White
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF1A1A1A); // Dark text
  static const Color lightTextSecondary = Color(0xFF6B6B6B); // Grey text
  static const Color lightTextTertiary = Color(0xFF9E9E9E);
  static const Color lightBorder = Color(0xFFE5E5E5);
  static const Color lightShadow = Color.fromRGBO(0, 0, 0, 0.05);
  static const Color lightSuccess = Color(0xFF10B981); // Green
  static const Color lightError = Color(0xFFEF4444); // Red
  static const Color lightWarning = Color(0xFFF59E0B); // Amber
  static const Color lightInfo = Color(0xFF3B82F6); // Blue

  // 🌙 Dark Theme Colors
  static const Color darkPrimary = Color(0xFF7C3AED); // Purple (same as light)
  static const Color darkSecondary = Color(0xFF2D2D3D); // Dark grey
  static const Color darkBackground = Color(0xFF0F0F1E); // Very dark navy
  static const Color darkCardBackground = Color(0xFF1A1A2E); // Dark card
  static const Color darkSurface = Color(0xFF1A1A2E);
  static const Color darkTextPrimary = Color(0xFFFFFFFF); // White text
  static const Color darkTextSecondary = Color(0xFFB0B0B0); // Light grey text
  static const Color darkTextTertiary = Color(0xFF808080);
  static const Color darkBorder = Color(0xFF2D2D3D);
  static const Color darkShadow = Color.fromRGBO(0, 0, 0, 0.3);
  static const Color darkSuccess = Color(0xFF10B981); // Green
  static const Color darkError = Color(0xFFEF4444); // Red
  static const Color darkWarning = Color(0xFFF59E0B); // Amber
  static const Color darkInfo = Color(0xFF3B82F6); // Blue

  // 🌐 Common Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color orange = Color(0xFFFF9800);
  static const Color blue = Color(0xFF2196F3);
  static const Color green = Color(0xFF4CAF50);
  static const Color red = Color(0xFFF44336);
  static const Color yellow = Color(0xFFFFEB3B);
  static const Color purple = Color(0xFF9C27B0);
  static const Color teal = Color(0xFF009688);
  static const Color indigo = Color(0xFF3F51B5);
  static const Color pink = Color(0xFFE91E63);
  static const Color amber = Color(0xFFFFC107);
  static const Color cyan = Color(0xFF00BCD4);
  static const Color lime = Color(0xFFCDDC39);
  static const Color brown = Color(0xFF795548);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color blueGrey = Color(0xFF607D8B);
}