import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/theme/font_wieght.dart';




abstract class AppTextStyles{
  static TextStyle font17WhiteMedium = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.white
  );
  static TextStyle font17BlackMedium = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.white
  );
  static TextStyle font17BlackRegular = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.white
  );
  static TextStyle font20BlackBold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.bold,
    color: AppColors.white
  );
} 