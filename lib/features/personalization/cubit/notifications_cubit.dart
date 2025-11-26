import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsState {
  final List<Map<String, dynamic>> notifications;
  final bool loading;

  NotificationsState({
    required this.notifications,
    this.loading = false,
  });

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

  Future<void> loadNotifications() async {
    emit(state.copyWith(loading: true));
    try {
      final snap = await _db
          .collection("notifications")
          .orderBy("createdAt", descending: true)
          .get();

      final data = snap.docs.map((e) => e.data()).toList();
      emit(state.copyWith(notifications: data, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false));
      print("Error loading notifications: $e");
    }
  }

  Future<void> pushOrderPlaced(String orderId) async {
    await _db.collection("notifications").add({
      "title": "Order Placed",
      "body": "Your order #$orderId has been placed successfully!",
      "createdAt": DateTime.now().toIso8601String(),
    });
    
    // تحديث القائمة فوراً بعد الإضافة
    await loadNotifications();
  }
}