import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemSkeleton extends StatelessWidget {
  final int itemCount;

  const CartItemSkeleton({
    super.key,
    this.itemCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(
        highlightColor: theme.surface,
        baseColor: theme.secondary,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, index) => Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: theme.surface,
            border: Border.all(color: theme.outline.withOpacity(0.1)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image skeleton
              Container(
                width: 80.r,
                height: 80.r,
                decoration: BoxDecoration(
                  color: theme.secondary,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title skeleton
                    Container(
                      height: 16.sp,
                      width: MediaQuery.of(context).size.width * 0.5,
                      color: theme.secondary,
                    ),
                    SizedBox(height: 4.h),
                    // Price skeleton
                    Container(
                      height: 16.sp,
                      width: MediaQuery.of(context).size.width * 0.2,
                      color: AppColors.figmaPrimary.withOpacity(0.5),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        // Size skeleton
                        Container(
                          height: 12.sp,
                          width: MediaQuery.of(context).size.width * 0.15,
                          color: theme.secondary.withOpacity(0.7),
                        ),
                        SizedBox(width: 12.w),
                        // Color skeleton
                        Container(
                          height: 12.sp,
                          width: MediaQuery.of(context).size.width * 0.15,
                          color: theme.secondary.withOpacity(0.7),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Delete icon skeleton
                  Container(
                    width: 20.r,
                    height: 20.r,
                    color: theme.secondary.withOpacity(0.7),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      // Minus button
                      Container(
                        width: 24.r,
                        height: 24.r,
                        decoration: BoxDecoration(
                          color: AppColors.darkPrimary.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      // Quantity text
                      Container(
                        width: 30.w,
                        height: 16.sp,
                        color: theme.secondary.withOpacity(0.7),
                      ),
                      SizedBox(width: 6.w),
                      // Plus button
                      Container(
                        width: 24.r,
                        height: 24.r,
                        decoration: BoxDecoration(
                          color: AppColors.darkPrimary.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
