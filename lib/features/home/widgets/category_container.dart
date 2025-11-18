import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';

class CategoryContainerItem extends StatelessWidget {
  const CategoryContainerItem({
    super.key,
    required this.image,
    required this.label,
    required this.categoryId,
  });

  final String image;
  final String label;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.productsByCategory,
            arguments: {'categoryId': categoryId, 'categoryName': label},
          );
        },
        child: Container(
          height: 64.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
            ),
          ),
          child: Row(
            children: [
              horizontalSpacing(12),
              CircleAvatar(
                radius: 24,
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                backgroundImage: NetworkImage(image),
              ),
              horizontalSpacing(12),
              Text(
                label,
                style: AppTextStyles.font17WiteRegular.copyWith(
                  fontSize: 16.sp,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
