import 'package:flutter/material.dart';

class PriceDetail extends StatelessWidget {
  const PriceDetail({super.key, required this.title,required this.price,  this.isPriceBolded = false});

  final String title;
  final double price;
 final bool? isPriceBolded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: theme.onSurfaceVariant,
            ),
          ),
          Text(
            "\$${price.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: isPriceBolded == true ? FontWeight.bold : FontWeight.w600,
              fontSize: 14,
              color: isPriceBolded == true ? theme.primary : theme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
