import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/text_style.dart';

class ProductWidget extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String? oldPrice;
  const ProductWidget({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    this.oldPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        width: 159,
        height: 281,
        decoration: BoxDecoration(
          color: AppColors.darkSecondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.asset(
                image,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                title,
                style: AppTextStyles.font17WiteRegular.copyWith(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Text(
                    price,
                    style: AppTextStyles.font17WiteRegular.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  if (oldPrice != null) ...[
                    const SizedBox(width: 8),
                    Text(
                      oldPrice!,
                      style: AppTextStyles.font17WiteRegular.copyWith(
                        color: Colors.white38,
                        fontSize: 13,
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
