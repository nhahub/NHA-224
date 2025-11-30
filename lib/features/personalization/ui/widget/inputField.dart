import 'package:flutter/material.dart';

class Inputfield extends StatelessWidget {
  const Inputfield({
    super.key,
    required this.hintText,
    required this.controller,
    required this.validator,
  });

  final String hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      validator: validator,

      style: TextStyle(
        color: theme.colorScheme.onSurface, 
        fontSize: 16,
      ),

      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: theme.inputDecorationTheme.labelStyle,

        filled: true,
        fillColor: theme.inputDecorationTheme.fillColor,

        border: theme.inputDecorationTheme.border,
        enabledBorder: theme.inputDecorationTheme.enabledBorder,
        focusedBorder: theme.inputDecorationTheme.focusedBorder,
        errorBorder: theme.inputDecorationTheme.errorBorder,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
