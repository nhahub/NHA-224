import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SizedBox verticalSpacing(double height) => SizedBox(height: height.h,);

SizedBox horizontalSpacing(double width) => SizedBox(width: width.w,);

abstract class Spacing {
  // Padding and Margin values
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;

  // Horizontal spacing
  static const double smH = 8.0;
  static const double mdH = 12.0;
  static const double lgH = 16.0;
  static const double xlH = 20.0;

  // Vertical spacing
  static const double smV = 8.0;
  static const double mdV = 12.0;
  static const double lgV = 16.0;
  static const double xlV = 20.0;

  // Border radius
  static const double smRadius = 4.0;
  static const double mdRadius = 8.0;
  static const double lgRadius = 12.0;
  static const double xlRadius = 16.0;
  static const double xxlRadius = 20.0;

  // Elevation
  static const double smElevation = 2.0;
  static const double mdElevation = 4.0;
  static const double lgElevation = 8.0;

  // Margin
  static const double smMargin = 8.0;
  static const double mdMargin = 12.0;
  static const double lgMargin = 16.0;
}