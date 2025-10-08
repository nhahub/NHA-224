
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter/material.dart';

class SelectFiled extends StatelessWidget {
  const SelectFiled({
    super.key,
    required this.isSelected,
    required this.option,
  });

  final bool isSelected;
  final String option;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: isSelected
            ? AppColors.darkPrimary
            : Colors.grey[200],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            option,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          if (isSelected)
            const Icon(Icons.check, color: Colors.white),
        ],
      ),
    );
  }
}
