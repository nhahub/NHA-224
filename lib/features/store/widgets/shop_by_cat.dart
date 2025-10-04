import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/features/store/widgets/cart_of_cat.dart';
import 'package:flutter/material.dart';

class ShopByCatWidget extends StatelessWidget {
  const ShopByCatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categories = [
      {"title": "Hoodies", "image": "assets/images/Ellipse 5 (1).png"},
      {"title": "Sneakers", "image": "assets/images/Ellipse 5 (2).png"},
      {"title": "T-Shirts", "image": "assets/images/Ellipse 5 (3).png"},
      {"title": "Bags", "image": "assets/images/Ellipse 5.png"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),

        Text(
          "Shop by Categories",
          // style: AppTextStyles.font20BlackBold.copyWith(
          //   fontFamily: 'cairo',
          //   fontWeight: FontWeight.w900, // bold
          // ),
          style: TextStyle(
            fontFamily: 'cairo',
            fontWeight: FontWeight.w900, // bold
            fontSize: 24,
            height: 1.0, // line-height: 100%
            letterSpacing: 0.0, // letter-spacing: 0%
          ),
        ),

        ListView.builder(
          itemCount: categories.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final category = categories[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CardOfCat(
                title: category["title"]!,
                imagePath: category["image"]!,
              ),
            );
          },
        ),
      ],
    );
  }
}
