import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';

class PriceDetail extends StatelessWidget {
  const PriceDetail({
    super.key,
    required this.title,
    required this.price,
    this.isPriceBolded = false,
  });

  final String title;
  final double price;
  final bool? isPriceBolded;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, color: AppColors.darkTextTertiary),
            ),
            Text(
              "\$${price.toStringAsFixed(2)}",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: isPriceBolded == true
                    ? FontWeight.bold
                    : FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
