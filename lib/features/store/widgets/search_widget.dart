import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final ValueChanged<String>? onChanged; // ← هنا ضفنا callback
  final VoidCallback? onClear; // اختياري لو عايز زرار clear يشتغل

  const SearchWidget({super.key, this.onChanged, this.onClear});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
            color: AppColors.lightSecondary, 
            borderRadius: BorderRadius.circular(24),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context); 
            },
            icon: Icon(Icons.arrow_back_ios, color: AppColors.black),
          ),
        ),
        SizedBox(width: 4),
        Expanded(
          child: TextField(
            onChanged: onChanged, // ← ربطنا الـ callback
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 12),
              hintText: "Search",
              hintStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 12,
                height: 1.6,
                letterSpacing: 0,
                color: AppColors.black
              ),
              prefixIcon: Icon(Icons.search, color: AppColors.black, size: 24),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear, color: AppColors.black),
                onPressed: onClear, // ← زرار clear لو موجود
              ),
              filled: true,
              fillColor: AppColors.lightSecondary,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
