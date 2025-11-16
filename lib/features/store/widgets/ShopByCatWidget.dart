import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/data/models/category_model.dart';
import 'package:depi_final_project/features/store/widgets/cart_of_cat.dart';

class ShopByCatWidget extends StatelessWidget {
  final List<CategoryModel> categories;
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
        Text(
          "Shop by Categories",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            // Switch to grid on wider layouts for better responsiveness
            final isGrid = constraints.maxWidth >= 600;
            if (!isGrid) {
              return ListView.builder(
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
              );
            }

            // Grid on tablets / wide screens
            final crossAxisCount = constraints.maxWidth >= 900 ? 3 : 2;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 3.2,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return CardOfCat(
                  title: category.name,
                  imageUrl: category.imageUrl,
                  onTap: () => onCategorySelected?.call(category.id),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
