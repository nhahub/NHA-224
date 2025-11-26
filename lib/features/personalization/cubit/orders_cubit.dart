import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersState {
  final List<Map<String, dynamic>> orders;
  final bool loading;

  OrdersState({required this.orders, this.loading = false});

  OrdersState copyWith({List<Map<String, dynamic>>? orders, bool? loading}) {
    return OrdersState(
      orders: orders ?? this.orders,
      loading: loading ?? this.loading,
    );
  }
}

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersState(orders: []));

  final _db = FirebaseFirestore.instance;

  Future<void> loadOrders() async {
    emit(state.copyWith(loading: true));
    try {
      final snap = await _db.collection("orders").orderBy("createdAt", descending: true).get();
      final data = snap.docs.map((e) => e.data()).toList();
      emit(state.copyWith(orders: data, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false));
      print("Error loading orders: $e");
    }
  }

  // التغيير هنا: الدالة تعيد String (رقم الطلب)
  Future<String> placeOrder({
    required double total,
    required int itemsCount,
  }) async {
    // 1. إنشاء رقم الطلب
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    // 2. إرسال البيانات لقاعدة البيانات
    await _db.collection("orders").add({
      "orderId": orderId,
      "total": total,
      "itemsCount": itemsCount,
      "status": "Processing",
      "createdAt": DateTime.now().toIso8601String(),
    });

    // 3. إعادة تحميل الطلبات لتظهر في الشاشة فوراً
    await loadOrders();

    // 4. إرجاع رقم الطلب لاستخدامه في الإشعار
    return orderId;
  }
}