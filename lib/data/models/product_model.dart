import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? oldPrice;
  final double rating;
  final int stock;
  final String productId;
  final List<String> colors;
  final List<String> sizes;
  final List<String> imageUrl;
  final DocumentReference? category;
  final String gender; // Men | Women | Unspecified
  final String? brand;
  final String? sku;
  final bool isFeatured;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.oldPrice,
    required this.rating,
    required this.stock,
    required this.productId,
    required this.colors,
    required this.sizes,
    required this.imageUrl,
    this.category,
    required this.gender,
    this.brand,
    this.sku,
    required this.isFeatured,
    required this.createdAt,
    this.updatedAt,
  });

  /// Create from Firestore DocumentSnapshot
  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return ProductModel(
      id: doc.id,
      name: (data['name'] as String?) ?? '',
      description: (data['description'] as String?) ?? '',
      price: _toDouble(data['price']),
      oldPrice: data['oldPrice'] != null ? _toDouble(data['oldPrice']) : null,
      rating: _toDouble(data['rating']),
      stock: _toInt(data['stock']),
      productId: (data['productId'] as String?) ?? doc.id,
      colors: _toStringList(data['colors']),
      sizes: _toStringList(data['sizes']),
      imageUrl: _toStringList(data['imageUrl']),
      category: data['category'] as DocumentReference?,
      gender: (data['gender'] as String?) ?? 'Unspecified',
      brand: data['brand'] as String?,
      sku: data['sku'] as String?,
      isFeatured: (data['isFeatured'] ?? false) as bool,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Create from Map (e.g., remote or local map)
  factory ProductModel.fromMap(Map<String, dynamic> data, {String? id}) {
    return ProductModel(
      id: id ?? (data['id'] as String?) ?? '',
      name: (data['name'] as String?) ?? '',
      description: (data['description'] as String?) ?? '',
      price: _toDouble(data['price']),
      oldPrice: data['oldPrice'] != null ? _toDouble(data['oldPrice']) : null,
      rating: _toDouble(data['rating']),
      stock: _toInt(data['stock']),
      productId: (data['productId'] as String?) ?? '',
      colors: _toStringList(data['colors']),
      sizes: _toStringList(data['sizes']),
      imageUrl: _toStringList(data['imageUrl']),
      category: data['category'] as DocumentReference?,
      gender: (data['gender'] as String?) ?? 'Unspecified',
      brand: data['brand'] as String?,
      sku: data['sku'] as String?,
      isFeatured: (data['isFeatured'] ?? false) as bool,
      createdAt: data['createdAt'] is Timestamp
          ? (data['createdAt'] as Timestamp).toDate()
          : (data['createdAt'] as DateTime?) ?? DateTime.now(),
      updatedAt: data['updatedAt'] is Timestamp
          ? (data['updatedAt'] as Timestamp).toDate()
          : (data['updatedAt'] as DateTime?),
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String)
      return int.tryParse(value) ?? double.tryParse(value)?.toInt() ?? 0;
    return 0;
  }

  static List<String> _toStringList(dynamic value) {
    if (value == null) return <String>[];
    if (value is Iterable) {
      try {
        return value
            .map((e) => e?.toString() ?? '')
            .where((s) => s.isNotEmpty)
            .toList();
      } catch (_) {
        return <String>[];
      }
    }
    if (value is String) {
      final str = value.trim();
      if (str.isEmpty) return <String>[];
      if (str.contains(',')) {
        return str
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();
      }
      return <String>[str];
    }
    return <String>[value.toString()];
  }

  /// Convert to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'oldPrice': oldPrice,
      'rating': rating,
      'stock': stock,
      'productId': productId,
      'colors': colors,
      'sizes': sizes,
      'imageUrl': imageUrl,
      'category': category,
      'gender': gender,
      'brand': brand,
      'sku': sku,
      'isFeatured': isFeatured,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    }..removeWhere((key, value) => value == null);
  }

  /// For simple JSON serialization (no DocumentReference)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'oldPrice': oldPrice,
      'rating': rating,
      'stock': stock,
      'productId': productId,
      'colors': colors,
      'sizes': sizes,
      'imageUrl': imageUrl,
      'category': category?.path,
      'gender': gender,
      'brand': brand,
      'sku': sku,
      'isFeatured': isFeatured,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    }..removeWhere((k, v) => v == null);
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? oldPrice,
    double? rating,
    int? stock,
    String? productId,
    List<String>? colors,
    List<String>? sizes,
    List<String>? imageUrl,
    DocumentReference? category,
    String? gender,
    String? brand,
    String? sku,
    bool? isFeatured,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      rating: rating ?? this.rating,
      stock: stock ?? this.stock,
      productId: productId ?? this.productId,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      gender: gender ?? this.gender,
      brand: brand ?? this.brand,
      sku: sku ?? this.sku,
      isFeatured: isFeatured ?? this.isFeatured,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() => 'ProductModel(id: $id, name: $name, price: $price)';
}
