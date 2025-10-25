import 'package:flutter/material.dart';
import 'package:depi_final_project/features/store/widgets/product_widget.dart';

class NewInList extends StatelessWidget {
  const NewInList({
    super.key,
    required this.newIn,
  });

  final List<Map<String, String>> newIn;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 281,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newIn.length,
        itemBuilder: (context, index) {
          final product = newIn[index];
          return ProductWidget(
            image: product['image']!,
            title: product['title']!,
            price: product['price']!,
          );
        },
      ),
    );
  }
}