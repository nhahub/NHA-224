import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:depi_final_project/core/theme/text_style.dart';

class ProductWidget extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String? oldPrice;
  final bool isFavorite;
  final VoidCallback? onTap;
  const ProductWidget({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    this.oldPrice,
    this.isFavorite = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        height: 300,
        margin: EdgeInsets.only(right: Spacing.lg, bottom: Spacing.sm),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(Spacing.lgRadius),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(Spacing.lgRadius),
                  ),
                  child: AspectRatio(
                    aspectRatio: 2.4 / 3, // Adjust this ratio as needed
                    child: Image.network(image, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: Spacing.sm,
                  right: Spacing.sm,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surface.withOpacity(0.8),
                    child: IconButton(
                      onPressed: () {
                        // TODO: Handle favorite toggle
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite
                            ? AppColors.figmaPrimary
                            : Theme.of(context).colorScheme.onSurface,
                        size: 16,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.md,
                vertical: Spacing.sm,
              ),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.md),
              child: Row(
                children: [
                  Text(
                    price,
                    style: AppTextStyles.labelLarge.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (oldPrice != null) ...[
                    SizedBox(width: Spacing.sm),
                    Text(
                      oldPrice!,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
