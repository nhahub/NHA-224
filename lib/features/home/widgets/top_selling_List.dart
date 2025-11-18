import 'package:flutter/material.dart';
import 'package:depi_final_project/data/models/product_model.dart';
import 'package:depi_final_project/features/store/screens/product_page.dart';
import 'package:depi_final_project/features/home/widgets/product_widget.dart';

class TopSellingList extends StatelessWidget {
  const TopSellingList({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return SizedBox(
            width: 180,
            child: ProductWidget(
              image: product.imageUrl.isNotEmpty ? product.imageUrl[0] : '',
              title: product.name,
              price: '\$${product.price.toStringAsFixed(2)}',
              oldPrice: product.oldPrice != null
                  ? '\$${product.oldPrice!.toStringAsFixed(2)}'
                  : null,
              isFavorite: false, // TODO: Add favorite logic
              onTap: () {
                // Navigate to product details
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductPage(product: product)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
