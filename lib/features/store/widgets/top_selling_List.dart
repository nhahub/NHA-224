import 'package:flutter/material.dart';
import 'package:depi_final_project/features/store/widgets/product_widget.dart';

class TopSellingList extends StatelessWidget {
  const TopSellingList({
    super.key,
    required this.topSelling,
  });

  final List<Map<String, String>> topSelling;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: topSelling.length,
        itemBuilder: (context, index) {
          final product = topSelling[index];
          return ProductWidget(
            image: product['image']!,
            title: product['title']!,
            price: product['price']!,
            oldPrice: product['oldPrice'],
          );
        },
      ),
    );
  }
}