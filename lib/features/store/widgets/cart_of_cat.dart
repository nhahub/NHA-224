import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter/material.dart';

class CardOfCat extends StatelessWidget {
  final String title;
  final String imagePath;

  const CardOfCat({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Image.asset(
              imagePath,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
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
    );
  }
}
