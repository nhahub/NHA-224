import 'package:depi_final_project/features/personalization/ui/widget/no_notifications_yet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// تأكد من تعديل المسارات حسب مكان ملفاتك
import 'package:depi_final_project/features/personalization/cubit/notifications_cubit.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationsCubit>().loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          // 1. التعامل مع الحالة الفارغة
          if (state.notifications.isEmpty) {
            return const NoNotificationsYet();
          }

          // 2. عرض القائمة مع Grey Cards
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.notifications.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final noti = state.notifications[index];

              return Card(
                color: Colors.grey[100], // اللون الرمادي المطلوب
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple.withOpacity(0.1),
                      child: const Icon(FontAwesomeIcons.bell, color: Colors.deepPurple, size: 20),
                    ),
                    title: Text(
                      noti["title"],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        noti["body"],
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    trailing: Text(
                      _formatTime(noti["createdAt"]), // دالة تنسيق الوقت
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // دالة مساعدة بسيطة لتنسيق الوقت (اختيارية)
  String _formatTime(String? dateString) {
    if (dateString == null) return "";
    try {
      final date = DateTime.parse(dateString);
      return "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return "";
    }
  }
}