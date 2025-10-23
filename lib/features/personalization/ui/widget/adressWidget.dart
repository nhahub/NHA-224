import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter/material.dart';

class Adresswidget extends StatelessWidget {
  const Adresswidget({super.key, required this.address});

  final String address;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(address, style: const TextStyle(fontSize: 14)),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Edit", style: TextStyle(color: AppColors.lightPrimary, fontSize: 11, fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Delete", style: TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.w600)),
          ),
          // IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: AppColors.lightPrimary, size: 16,))
        ],
      ),
    );
  }
}