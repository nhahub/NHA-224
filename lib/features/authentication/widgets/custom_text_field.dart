import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  String labelText;

  CustomTextField({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        fillColor: AppColors.darkSecondary,
        filled: true,
        labelText: labelText,
        labelStyle: TextStyle(color: AppColors.darkTextSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
