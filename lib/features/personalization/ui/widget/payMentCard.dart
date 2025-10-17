import 'package:flutter/material.dart';

class Paymentcard extends StatelessWidget {
  const Paymentcard({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(child: Text(text)),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}