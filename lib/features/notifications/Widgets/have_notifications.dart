import 'package:depi_final_project/features/Notifications/Widgets/notification_card_implementation.dart';
import 'package:flutter/material.dart';

class HaveNotifications extends StatelessWidget {
  const HaveNotifications({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return NotificationCardComponent(message: message);

  }
}

