import '../models/product_model.dart';
import '../models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // جلب كل الكاتيجوريز
  Future<List<Category>> getCategories() async {
    final snapshot = await firestore.collection('categories').get();
    return snapshot.docs.map((doc) => Category.fromFirestore(doc)).toList();
  }

  // جلب كل المنتجات
  Future<List<ProductModel>> getProducts() async {
    final snapshot = await firestore.collection('products').get();
    return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
  }

  // جلب منتجات حسب الكاتيجوري
  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    final snapshot = await firestore
        .collection('products')
        .where('category', isEqualTo: firestore.collection('categories').doc(categoryId))
        .get();
    return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
  }
}
