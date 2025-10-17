import 'package:flutter/material.dart';

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
      height: 280,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
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
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.asset(
                  widget.imageUrl,
                  width: 160,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
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
                      color: isFavorite ? Colors.red : Colors.grey[400],
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
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
          Text(
            "\$${widget.price.toStringAsFixed(2)}",
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
