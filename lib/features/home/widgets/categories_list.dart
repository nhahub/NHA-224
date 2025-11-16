import 'package:flutter/material.dart';
import 'package:depi_final_project/data/models/category_model.dart';
import 'package:depi_final_project/features/home/widgets/catrgoery_widget.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
    required this.categories,
  });

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return CatrgoeryWidget(
            image: category.imageUrl,
            label: category.name,
            categoryId: category.id,
          );
        },
      ),
    );
  }
}
