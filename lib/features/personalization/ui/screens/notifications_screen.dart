import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: hasNotifications
          ? ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10),
              padding: const EdgeInsets.only(top: 30, left: 12, right: 12),
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
