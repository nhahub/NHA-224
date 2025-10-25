import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';

class CatrgoeryWidget extends StatelessWidget {
  final String image;
  final String label;
  const CatrgoeryWidget({super.key, required this.image, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.darkSecondary,
            backgroundImage: AssetImage(image),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
