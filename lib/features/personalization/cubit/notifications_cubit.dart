import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // استدعاء المكتبة
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsState {
  final List<Map<String, dynamic>> notifications;
  final bool loading;

  NotificationsState({required this.notifications, this.loading = false});

  NotificationsState copyWith({
    List<Map<String, dynamic>>? notifications,
    bool? loading,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      loading: loading ?? this.loading,
    );
  }
}

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsState(notifications: []));

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // جلب إشعارات اليوزر الحالي فقط
  Future<void> loadNotifications() async {
    emit(state.copyWith(loading: true));
    try {
      final user = _auth.currentUser;

      if (user == null) {
        emit(state.copyWith(loading: false, notifications: []));
        return;
      }

      final snap = await _db
          .collection("notifications")
          .where("userId", isEqualTo: user.uid) // فلترة بالـ ID
          .orderBy("createdAt", descending: true)
          .get();

      final data = snap.docs.map((e) => e.data()).toList();

      emit(state.copyWith(notifications: data, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false));
      print("Error loading notifications: $e");
    }
  }

  // إضافة إشعار لليوزر ده
  Future<void> pushOrderPlaced(String orderId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _db.collection("notifications").add({
      "title": "Order Placed",
      "body": "Your order #$orderId has been placed successfully!",
      "userId": user.uid, // ربط الإشعار باليوزر
      "createdAt": DateTime.now().toIso8601String(),
    });

    await loadNotifications();
  }
}
