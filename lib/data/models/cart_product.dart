import 'package:cloud_firestore/cloud_firestore.dart';

class CartProduct {
  String productId;
  String selectedSize;
  String selectedColor;
  int quantity;

  CartProduct({
    required this.productId,
    required this.selectedSize,
    required this.selectedColor,
    required this.quantity
  });


  factory CartProduct.fromFirestore(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;
    return CartProduct(
      productId: data['productId'], 
      selectedSize: data['selectedSize'], 
      selectedColor: data['selectedColor'], 
      quantity: data['quantity']);
}


Map<String, dynamic> toFirestore(){
  return {
    'productId': productId,
    'selectedSize': selectedSize,
    'selectedColor': selectedColor,
    'quantity': quantity
  };
}

}