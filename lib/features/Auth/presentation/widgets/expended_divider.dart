
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter/material.dart';

class ExpandedDivider extends StatelessWidget {
  const ExpandedDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Divider(color: AppColors.darkTextSecondary),
    );
  }
}
