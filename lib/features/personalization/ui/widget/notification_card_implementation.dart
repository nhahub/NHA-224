import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationCardComponent extends StatelessWidget {
  const NotificationCardComponent({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkSecondary,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(
          FontAwesomeIcons.bell,
          color: AppColors.darkTextPrimary,
        ),
        title: Text(
          message,
          style: AppTextStyles.font17WiteRegular.copyWith(fontSize: 14),
        ),
      ),
    );
  }
}
