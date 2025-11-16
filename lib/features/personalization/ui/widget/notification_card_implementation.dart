import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationCardComponent extends StatelessWidget {
  const NotificationCardComponent({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceVariant,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Spacing.lgRadius),
      ),
      elevation: Spacing.smElevation,
      child: ListTile(
        leading: Icon(
          FontAwesomeIcons.bell,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          message,
          style: AppTextStyles.bodyMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
