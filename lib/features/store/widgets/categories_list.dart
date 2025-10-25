import 'package:flutter/material.dart';
import 'package:depi_final_project/features/store/widgets/catrgoery_widget.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
    required this.categories,
  });

  final List<Map<String, String>> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final item = categories[index];
          return CatrgoeryWidget(
            image: item['image']!,
            label: item['label']!,
          );
        },
      ),
    );
  }
}