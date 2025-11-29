import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depi_final_project/data/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteRepo {

  final String userId = FirebaseAuth.instance.currentUser!.uid;
  Future<void> addProductToFavs(ProductModel product) async{
    await FirebaseFirestore.instance.
    collection("users")
    .doc(userId)
    .collection("favorites")
    .doc(product.id)
    .set(product.toMap());
  }

  Future<bool> isProductFavored(String productId) async {
    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("favorites")
        .doc(productId)
        .get();
    return doc.exists;
  }

  Future<void> removeProductFromFavs(String productId) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("favorites")
        .doc(productId)
        .delete();
  }


  Future<bool> toggleFavoriteStatus(ProductModel product) async {
    final isFavored = await isProductFavored(product.id);
    if (isFavored) {
      await removeProductFromFavs(product.id);
      return false;
    } else {
      await addProductToFavs(product);
      return true;
    }
  }
}