// import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/data/models/category_model.dart';
import 'package:flutter/material.dart';
// import 'package:depi_final_project/features/store/widgets/cart_of_cat.dart';
class ShopByCatWidget extends StatelessWidget {
  final List<Category> categories;
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
          leading: Image.network(category.imageUrl, width: 50, height: 50),
          title: Text(category.name),
          onTap: () => onCategorySelected(category.id),
        );
      },
    );
  }
}
