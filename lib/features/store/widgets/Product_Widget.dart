import 'package:depi_final_project/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/text_style.dart';

class ProductWidgetSearch extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String? oldPrice;
  final void Function() onTap;
  const ProductWidgetSearch({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.oldPrice, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
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
                child: Image.network(
                  imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey,
                    height: 180,
                  ), // لو الصورة ما ظهرتش
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
      ),
    );
  }
}
