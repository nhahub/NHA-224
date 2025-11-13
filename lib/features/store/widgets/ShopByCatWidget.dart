import 'package:flutter/material.dart';
import 'package:depi_final_project/features/store/widgets/cart_of_cat.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/data/models/category_model.dart';

class ShopByCatWidget extends StatelessWidget {
  final List<Category> categories;
  final Function(String categoryId)? onCategorySelected;

  const ShopByCatWidget({
    super.key,
    required this.categories,
    this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        const Text(
          "Shop by Categories",
          style: TextStyle(
            fontFamily: 'cairo',
            fontWeight: FontWeight.w900,
            fontSize: 24,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          itemCount: categories.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final category = categories[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CardOfCat(
                title: category.name,
                imageUrl: category.imageUrl,
                onTap: () => onCategorySelected?.call(category.id),
              ),
            );
          },
        ),
      ],
    );
  }
}
