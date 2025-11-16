import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/widgets/app_bar_widget.dart';
import 'package:depi_final_project/features/personalization/ui/widget/have_notifications.dart';
import 'package:depi_final_project/features/personalization/ui/widget/no_notifications_yet.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  final List<String> dummyNotificationsData = const [
    "Gilbert, you placed an order check your order history for full details",
    "Gilbert, Thank you for shopping with us we have canceled order #24566",
    "Gilbert, your Order #24568 has been confirmed check your order history",
  ];

  @override
  Widget build(BuildContext context) {
    final bool hasNotifications = dummyNotificationsData.isNotEmpty;

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Notifications",
        automaticallyImplyLeading: false,
      ),
      body: hasNotifications
          ? ListView.separated(
              separatorBuilder: (context, index) =>
                  SizedBox(height: Spacing.md),
              padding: EdgeInsets.only(
                top: Spacing.xxxl,
                left: Spacing.md,
                right: Spacing.md,
              ),
              itemCount: dummyNotificationsData.length,
              itemBuilder: (context, index) {
                return HaveNotifications(
                  message: dummyNotificationsData[index],
                );
              },
            )
          : const NoNotificationsYet(),
    );
  }
}
