import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:depi_final_project/core/theme/text_style.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Spacing.lgRadius),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.lgH,
          vertical: Spacing.md,
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.button.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
