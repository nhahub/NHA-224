import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
// import 'package:depi_final_project/core/routes/app_routes.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final VoidCallback? onSeeAllTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.titleColor,
    this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.font17WhiteMedium.copyWith(
            color: titleColor ?? Theme.of(context).colorScheme.onSurface,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: onSeeAllTap,
          child: Text(
            'See All',
            style: AppTextStyles.font17WhiteMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }
}
