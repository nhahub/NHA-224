import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter/material.dart';

class CardOfCat extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback? onTap; // <- جديد

  const CardOfCat({
    super.key,
    required this.title,
    required this.imageUrl,
    this.onTap, // <- جديد
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // <- استخدمناها هنا
      child: Container(
        height: 64,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.lightSecondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                imageUrl,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  size: 40,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontFamily: "CircularStd",
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 16,
                height: 1.0,
                letterSpacing: 0,
                color: Color.fromRGBO(39, 39, 39, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
