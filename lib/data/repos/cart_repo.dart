import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depi_final_project/data/models/cart_product.dart';
import 'package:depi_final_project/data/models/product_model.dart';
import 'package:depi_final_project/data/repos/cart_with_details.dart';
import 'package:depi_final_project/features/store/screens/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartRepo {

  final String userId = FirebaseAuth.instance.currentUser!.uid;
  void addToUserCart(CartProduct cartProduct){
    FirebaseFirestore.instance.collection("users")
    .doc(userId)
    .collection("cart")
    .add(cartProduct.toFirestore());
  }


  void removeFromUserCart(String cartProductId){

  }


 Future<List<CartProduct>> loadCartItems() async{
  final querySnapShot = await FirebaseFirestore.instance
  .collection("users")
  .doc(userId)
  .collection('cart')
  .get();

  return querySnapShot.docs
  .map((doc) => CartProduct.fromFirestore(doc))
  .toList();
 }


 Future<ProductModel> loadProductById(String productId)async{
  final doc = await FirebaseFirestore.instance
  .collection("products")
  .doc(productId)
  .get();

  return ProductModel.fromFirestore(doc);

 }

 Future<List<CartWithDetails>> loadCartProducts() async{
  final cartItems = await loadCartItems();

  return Future.wait(cartItems.map((item) async {
    final product = await loadProductById(item.productId);

    return CartWithDetails(
      product: product,
      cartDetails: item, 
    );
  }));
 }
  
}