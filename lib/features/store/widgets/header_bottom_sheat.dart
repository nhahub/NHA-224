import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class HeaderBottomSheet extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const HeaderBottomSheet({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(onPressed: () => onTap, child: Text("Clear")),
        Text(
          text,
          style: AppTextStyles.font20BlackBold.copyWith(
            // fontSize: 28,
            fontWeight: FontWeight.w900,
            fontFamily: 'cairo',
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close, size: 20),
        ),
      ],
    );
  }
}
