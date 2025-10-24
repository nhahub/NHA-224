import 'package:flutter/material.dart';
import 'package:depi_final_project/features/personalization/ui/widget/notification_card_implementation.dart';

class HaveNotifications extends StatelessWidget {
  const HaveNotifications({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return NotificationCardComponent(message: message);

  }
}

