import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/theme/font_wieght.dart';

abstract class AppTextStyles {
  // Headline styles
  static TextStyle headline1 = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeightHelper.bold,
    color: AppColors.lightTextPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle headline2 = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeightHelper.bold,
    color: AppColors.lightTextPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle headline3 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.lightTextPrimary,
    letterSpacing: -0.25,
  );

  static TextStyle headline4 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.lightTextPrimary,
  );

  static TextStyle headline5 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.lightTextPrimary,
  );

  static TextStyle headline6 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.lightTextPrimary,
  );

  // Body text styles
  static TextStyle bodyLarge = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.lightTextPrimary,
    height: 1.5,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.lightTextPrimary,
    height: 1.5,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.lightTextSecondary,
    height: 1.4,
  );

  static TextStyle bodyExtraSmall = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.lightTextTertiary,
    height: 1.4,
  );

  // Label styles
  static TextStyle labelLarge = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.lightTextPrimary,
    letterSpacing: 0.1,
  );

  static TextStyle labelMedium = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.lightTextSecondary,
    letterSpacing: 0.5,
  );

  static TextStyle labelSmall = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.lightTextTertiary,
    letterSpacing: 0.5,
  );

  // Button styles
  static TextStyle button = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.white,
    letterSpacing: 1.25,
  );

  static TextStyle buttonText = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.lightPrimary,
    letterSpacing: 1.25,
  );

  // Legacy styles (for backward compatibility)
  static TextStyle font17WhiteMedium = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.white,
  );
  static TextStyle font17BlackMedium = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.lightTextPrimary,
  );
  static TextStyle font17BlackRegular = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.lightTextPrimary,
  );
  static TextStyle font17WiteRegular = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.white,
  );
  static TextStyle font20WitekBold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.bold,
    color: AppColors.white,
  );
  static TextStyle font20BlackBold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: AppColors.lightTextPrimary,
  );
}
