import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';

class CatrgoeryWidget extends StatelessWidget {
  final String image;
  final String label;
  final String categoryId;
  const CatrgoeryWidget({
    super.key,
    required this.image,
    required this.label,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.productsByCategory,
            arguments: {'categoryId': categoryId, 'categoryName': label},
          );
        },
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              backgroundImage: NetworkImage(image),
            ),
            verticalSpacing(5),
            Text(
              label,
              style: AppTextStyles.labelLarge.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
