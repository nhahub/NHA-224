import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depi_final_project/data/models/cart_product.dart';
import 'package:depi_final_project/data/models/product_model.dart';
import 'package:depi_final_project/features/store/screens/cart.dart';
import 'package:depi_final_project/data/repos/cart_with_details.dart';

class CartRepo {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  String _getDocId(String productId, String size, String color) {
    return '${productId}_${size}_${color}';
  }

  Future<void> addToUserCart(CartProduct newProduct) async {
    final docId = _getDocId(newProduct.productId, newProduct.selectedSize, newProduct.selectedColor);
    final docRef = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("cart")
        .doc(docId);
    
    final docSnap = await docRef.get();
    
    if (docSnap.exists) {
      final data = docSnap.data()!;
      final updatedQuantity = data['quantity'] + newProduct.quantity;
      await docRef.set({
        'productId': newProduct.productId,
        'selectedSize': newProduct.selectedSize,
        'selectedColor': newProduct.selectedColor,
        'quantity': updatedQuantity,
      });
    } else {
      await docRef.set(newProduct.toFirestore());
    }

    // Update product stock
    final productRef = FirebaseFirestore.instance.collection('products').doc(newProduct.productId);
    await productRef.update({
      'stock': FieldValue.increment(-newProduct.quantity)
    });
  }

  Future<List<CartProduct>> loadCartItems() async {
    final querySnapShot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection('cart')
        .get();

    return querySnapShot.docs
        .map((doc) => CartProduct.fromFirestore(doc))
        .toList();
  }

  Future<ProductModel> loadProductById(String productId) async {
    final doc = await FirebaseFirestore.instance
        .collection("products")
        .doc(productId)
        .get();

    return ProductModel.fromFirestore(doc);
  }

  Future<List<CartWithDetails>> loadCartProducts() async {
    final cartItems = await loadCartItems();

    return Future.wait(
      cartItems.map((item) async {
        final product = await loadProductById(item.productId);

        return CartWithDetails(product: product, cartDetails: item);
      }),
    );
  }

  Future<void> removeAllCartProduct() async {
    final collection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart');

    final snapshot = await collection.get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> editCartItemQuantity(String productId, String size, String color, int quantity) async {
    final docId = _getDocId(productId, size, color);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection('cart')
        .doc(docId)
        .set({"quantity": quantity}, SetOptions(merge: true));
  }

  Future<void> deleteCartItem(String productId, String size, String color) async {
    final docId = _getDocId(productId, size, color);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("cart")
        .doc(docId)
        .delete();
  }
}
