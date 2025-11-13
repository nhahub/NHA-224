import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final int stock;
  final String productId;
  final List<String> colors;
  final List<String> sizes;
  final List<String> imageUrl;
  final DocumentReference category; // ربط بالفئة (Category)
  final DateTime createdAt;
  final String gender; // إضافة حقل الـ Gender
  final double? oldPrice; // <- هنا ضفت المتغير الجديد
  final String selectedSize;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.stock,
    required this.productId,
    required this.colors,
    required this.sizes,
    required this.imageUrl,
    required this.category,
    required this.createdAt,
    this.oldPrice,

    required this.gender, // تعديل الكونستركتور
    required this.selectedSize,
  });

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      rating: (data['rating'] ?? 0).toDouble(),
      stock: data['stock'] ?? 0,
      productId: data['productId'] ?? '',
      colors: List<String>.from(data['color'] ?? []),
      sizes: List<String>.from(data['size'] ?? []),
      imageUrl:List<String>.from( data['imageUrl'] ?? ''),
      category: data['category'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      oldPrice: data['oldPrice'] != null
          ? (data['oldPrice'] as num).toDouble()
          : null,

      gender: data['gender'] ?? 'Men', 
      selectedSize: data['selectedSize']??"no sizes", // قيمة افتراضية لو مش موجودة
      
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'rating': rating,
      'stock': stock,
      'productId': productId,
      'color': colors,
      'size': sizes,
      'imageUrl': imageUrl,
      'category': category,
      'createdAt': Timestamp.fromDate(createdAt),
      'oldPrice': oldPrice,

      'gender': gender, // إضافة للـ Firestore
      'selectedSize': selectedSize
    };
  }
}
