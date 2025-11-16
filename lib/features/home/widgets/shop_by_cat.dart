import 'package:flutter/material.dart';
import 'package:depi_final_project/data/models/category_model.dart';
// import 'package:depi_final_project/core/theme/colors.dart';
// import 'package:depi_final_project/features/store/widgets/cart_of_cat.dart';
class ShopByCatWidget extends StatelessWidget {
  final List<CategoryModel> categories;
  final Function(String categoryId) onCategorySelected;

  const ShopByCatWidget({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final category = categories[index];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              category.imageUrl,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            category.name,
            style: Theme.of(context).textTheme.bodyLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () => onCategorySelected(category.id),
          tileColor: Theme.of(context).colorScheme.surfaceVariant,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        );
      },
    );
  }
}
