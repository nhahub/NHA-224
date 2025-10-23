import 'package:flutter/material.dart';

class NotificationCardComponent extends StatelessWidget {
  const NotificationCardComponent({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.notifications_none, color: Colors.black54),
        title: Text(message, style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}
