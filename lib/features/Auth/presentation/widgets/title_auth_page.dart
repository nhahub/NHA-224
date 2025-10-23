import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter/material.dart';

class TitleAuthPages extends StatelessWidget {
  final String text;
  const TitleAuthPages({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'cairo',
        fontWeight: FontWeight.w900, // bold
        fontSize: 30,
        color: AppColors.black, // letter-spacing: 0%
      ),
    );
  }
}
