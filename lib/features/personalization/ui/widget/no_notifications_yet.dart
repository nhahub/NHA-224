import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:depi_final_project/features/personalization/ui/widget/button.dart';


class NoNotificationsYet extends StatelessWidget {
  const NoNotificationsYet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/notification.png",
            width: 100,
            height: 100,
          ),
          SizedBox(height: Spacing.lg),
          Text(
            "No Notification yet",
            style: AppTextStyles.headline4.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: Spacing.lg),
          Button(text: "Explore Categories"),
        ],
      ),
    );
  }
}
