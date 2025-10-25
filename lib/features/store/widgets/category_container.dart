import 'package:flutter/material.dart';
import 'package:depi_final_project/shared/spacing.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/theme/text_style.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        height: 64.h,
        decoration: BoxDecoration(
          color: AppColors.darkSecondary,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            horizontalSpacing(12),
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.darkSecondary,
              backgroundImage: AssetImage('assets/images/Ellipse 5 (1).png'),
            ),
            horizontalSpacing(12),
            Text(
              'Shorts',
              style: AppTextStyles.font17WiteRegular.copyWith(fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}
