import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 1. استدعاء مكتبة الـ Auth
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersState {
  final List<Map<String, dynamic>> orders;
  final bool loading;
  final String errorMessage; // 1. ده المتغير اللي كان ناقص

  OrdersState({
    required this.orders,
    this.loading = false,
    this.errorMessage = '', // 2. قيمة افتراضية فارغة
  });

  OrdersState copyWith({
    List<Map<String, dynamic>>? orders,
    bool? loading,
    String? errorMessage, // 3. إضافته في copyWith
  }) {
    return OrdersState(
      orders: orders ?? this.orders,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersState(orders: []));

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance; // 2. انستانس للـ Auth

  // دالة جلب الطلبات الخاصة باليوزر فقط
  Future<void> loadOrders() async {
    emit(state.copyWith(loading: true));
    try {
      final user = _auth.currentUser;

      // لو مفيش يوزر مسجل، نرجع ليست فاضية
      if (user == null) {
        emit(state.copyWith(loading: false, orders: []));
        return;
      }

      final snap = await _db
          .collection("orders")
          .where(
            "userId",
            isEqualTo: user.uid,
          ) // 3. الشرط: هاتلي طلبات اليوزر ده بس
          .orderBy("createdAt", descending: true)
          .get();

      final data = snap.docs.map((e) => e.data()).toList();
      emit(state.copyWith(orders: data, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false));
      print("Error loading orders: $e");
    }
  }

  // دالة إضافة طلب جديد مربوط باليوزر
  Future<String> placeOrder({
    required double total,
    required int itemsCount,
  }) async {
    final user = _auth.currentUser;

    // تأكد إن في يوزر مسجل دخول
    if (user == null) {
      throw Exception("يجب تسجيل الدخول لإتمام الطلب");
    }

    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    await _db.collection("orders").add({
      "orderId": orderId,
      "userId": user.uid, // 4. تخزين الـ UID (زي اللي في الصورة عندك)
      "userName": user.displayName ?? "Unknown", // اختياري
      "userEmail": user.email, // اختياري
      "total": total,
      "itemsCount": itemsCount,
      "status": "Processing",
      "createdAt": DateTime.now().toIso8601String(),
    });

    // تحديث القائمة فوراً
    await loadOrders();

    return orderId;
  }
}
