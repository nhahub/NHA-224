import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/spacing.dart';

class ProductSkeleton extends StatelessWidget {
  final int itemCount;

  const ProductSkeleton({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(
        highlightColor: theme.surface,
        baseColor: theme.secondary,
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.56,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.all(Spacing.sm),
          decoration: BoxDecoration(
            color: theme.surfaceVariant,
            borderRadius: BorderRadius.circular(Spacing.lgRadius),
            boxShadow: [
              BoxShadow(
                color: theme.shadow.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image skeleton
              AspectRatio(
                aspectRatio: 2.4 / 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.secondary,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(Spacing.lgRadius),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.md,
                  vertical: Spacing.sm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title skeleton
                    Container(
                      height: 16,
                      width: MediaQuery.of(context).size.width * 0.3,
                      color: theme.secondary,
                      margin: const EdgeInsets.only(bottom: 4),
                    ),
                    Container(
                      height: 14,
                      width: MediaQuery.of(context).size.width * 0.2,
                      color: theme.secondary.withOpacity(0.7),
                      margin: const EdgeInsets.only(bottom: 8),
                    ),
                    // Price skeleton
                    Row(
                      children: [
                        Container(
                          height: 16,
                          width: MediaQuery.of(context).size.width * 0.15,
                          color: AppColors.figmaPrimary.withOpacity(0.5),
                          margin: const EdgeInsets.only(right: 8),
                        ),
                        Container(
                          height: 12,
                          width: MediaQuery.of(context).size.width * 0.1,
                          color: theme.secondary.withOpacity(0.6),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
