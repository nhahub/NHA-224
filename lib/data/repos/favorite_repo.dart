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

  Future<List<ProductModel>> getFavoriteProducts() async {
    // Read favorite docs (assumes each favorite doc id is the productId)
    final favSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("favorites")
        .get();

    final ids = favSnapshot.docs.map((d) => d.id).toList();
    if (ids.isEmpty) return [];

    final productsRef = FirebaseFirestore.instance.collection('products');
    const int batchSize = 10; // Firestore whereIn limit
    final List<ProductModel> products = [];

    for (var i = 0; i < ids.length; i += batchSize) {
      final end = (i + batchSize > ids.length) ? ids.length : i + batchSize;
      final chunk = ids.sublist(i, end);
      final query = await productsRef
          .where(FieldPath.documentId, whereIn: chunk)
          .get();
      products.addAll(query.docs.map((d) => ProductModel.fromMap(d.data())).toList());
    }

    // Preserve the order of favorites
    final Map<String, ProductModel> byId = { for (var p in products) p.id : p };
    return ids.map((id) => byId[id]).whereType<ProductModel>().toList();
  }


}