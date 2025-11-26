import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceOrderCubit extends Cubit<bool> {
  PlaceOrderCubit() : super(false);

  Future<void> placeOrder({
    required double total,
    required int itemsCount,
  }) async {
    emit(true);

    try {
      /// 1) Add order to Firestore
      await FirebaseFirestore.instance.collection("orders").add({
        "orderId": DateTime.now().millisecondsSinceEpoch.toString(),
        "itemsCount": itemsCount,
        "total": total,
        "status": "Processing",
        "createdAt": Timestamp.now(),
      });

      /// 2) Add notification to Firestore
      await FirebaseFirestore.instance.collection("notifications").add({
        "title": "New Order",
        "body": "Order placed successfully",
        "createdAt": Timestamp.now(),
      });

    } catch (e) {
      print("ERROR placing order: $e");
    }

    emit(false);
  }
}
