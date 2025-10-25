import 'package:flutter/material.dart';

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
            backgroundColor: const Color(0xFF1E1A2E),
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