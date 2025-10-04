import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

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
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 12),
              hintText: "Search",
              hintStyle: TextStyle(
                // fontFamily:
                //     "Circular Std",
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 12,
                height: 1.6,
                letterSpacing: 0,
              ),
              prefixIcon: Icon(Icons.search, color: AppColors.black, size: 24),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear, color: AppColors.black),
                onPressed: () {},
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
