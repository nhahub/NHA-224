import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:depi_final_project/features/store/widgets/counter_btn.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.image, required this.price, required this.size, required this.color, required this.title});

  final String image;
  final String title;
  final double price;
  final String size;
  final String color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.surface,
        border: Border.all(color: theme.outline.withOpacity(0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(image, width: 80, height: 80, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: theme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "\$${price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: theme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "Size $size",
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Color $color",
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    CounterBtn(icon: "+"),
                    const SizedBox(width: 12),
                    CounterBtn(icon: "-"),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: theme.error,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
