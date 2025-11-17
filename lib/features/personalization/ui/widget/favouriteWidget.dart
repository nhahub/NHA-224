import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:depi_final_project/core/theme/text_style.dart';

class FavouriteWidget extends StatefulWidget {
  final String imageUrl;
  final String name;
  final double price;

  const FavouriteWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
  });

  @override
  State<FavouriteWidget> createState() => _FavouriteWidgetState();
}

class _FavouriteWidgetState extends State<FavouriteWidget> {
  bool isFavorite = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 300,
      margin: EdgeInsets.all(Spacing.md),
      padding: EdgeInsets.all(Spacing.sm),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(Spacing.lgRadius),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Spacing.lgRadius),
                  topRight: Radius.circular(Spacing.lgRadius),
                ),
                child: Image.asset(
                  widget.imageUrl,
                  width: 160,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: Spacing.sm,
                right: Spacing.sm,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  child: IconButton(
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: isFavorite
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 24,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          Text(
            widget.name,
            style: AppTextStyles.bodySmall.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Text(
            "\${widget.price.toStringAsFixed(2)}",
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
