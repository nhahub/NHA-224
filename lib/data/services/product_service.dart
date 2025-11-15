import 'dart:io';
import 'dart:convert';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final FirebaseFirestore _db;
  final String? cloudinaryCloudName;
  final String? cloudinaryUploadPreset;

  /// Provide `cloudinaryCloudName` and `cloudinaryUploadPreset` to enable
  /// client-side unsigned uploads to Cloudinary. For secure deletion you
  /// should implement a server-side endpoint.
  ProductService({
    FirebaseFirestore? firestore,
    this.cloudinaryCloudName,
    this.cloudinaryUploadPreset,
  }) : _db = firestore ?? FirebaseFirestore.instance;

  Future<String> addProduct(ProductModel model, {List<File>? imageFiles}) async {
    final docRef = _db.collection('products').doc();
    try {
      List<String> uploadedUrls = [];
      if (imageFiles != null && imageFiles.isNotEmpty) {
        if (cloudinaryCloudName != null && cloudinaryUploadPreset != null) {
          uploadedUrls = await _uploadFilesToCloudinary(imageFiles);
        } else {
          throw Exception('Cloudinary configuration missing for image upload');
        }
      }

      final data = model.copyWith(id: docRef.id, imageUrl: uploadedUrls).toMap();
      await docRef.set(data);
      return docRef.id;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(
    String id,
    ProductModel model, {
    List<File>? imageFilesToAdd,
    List<String>? imageUrlsToRemove,
  }) async {
    final docRef = _db.collection('products').doc(id);
    try {
      final current = await docRef.get();
      if (!current.exists) throw Exception('Product not found');

      List<String> finalUrls = List<String>.from(model.imageUrl);

      // Remove references (server should handle actual Cloudinary deletion)
      if (imageUrlsToRemove != null && imageUrlsToRemove.isNotEmpty) {
        for (final url in imageUrlsToRemove) {
          finalUrls.remove(url);
        }
      }

      if (imageFilesToAdd != null && imageFilesToAdd.isNotEmpty) {
        if (cloudinaryCloudName != null && cloudinaryUploadPreset != null) {
          final added = await _uploadFilesToCloudinary(imageFilesToAdd);
          finalUrls.addAll(added);
        } else {
          throw Exception('Cloudinary configuration missing for image upload');
        }
      }

      final data = model.copyWith(imageUrl: finalUrls).toMap();
      await docRef.update(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProduct(String id) async {
    final docRef = _db.collection('products').doc(id);
    try {
      final doc = await docRef.get();
      if (doc.exists) {
        // We remove Firestore document; Cloudinary resource deletion should
        // be handled server-side with authenticated API keys.
        await docRef.delete();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductModel?> getProductById(String id) async {
    final doc = await _db.collection('products').doc(id).get();
    if (!doc.exists) return null;
    return ProductModel.fromFirestore(doc);
  }

  Future<List<ProductModel>> getAllProducts() async {
    final snap = await _db.collection('products').get();
    return snap.docs.map((d) => ProductModel.fromFirestore(d)).toList();
  }

  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    final categoryRef = _db.collection('categories').doc(categoryId);
    final snap = await _db.collection('products').where('category', isEqualTo: categoryRef).get();
    return snap.docs.map((d) => ProductModel.fromFirestore(d)).toList();
  }

  Stream<List<ProductModel>> productsStream() {
    return _db.collection('products').snapshots().map((s) => s.docs.map((d) => ProductModel.fromFirestore(d)).toList());
  }

  Future<List<String>> _uploadFilesToCloudinary(List<File> files) async {
    if (cloudinaryCloudName == null || cloudinaryUploadPreset == null) {
      throw Exception('Cloudinary configuration missing');
    }
    final List<String> urls = [];
    for (final file in files) {
      final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudinaryCloudName/image/upload');
      final request = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = cloudinaryUploadPreset!;
      final bytes = await file.readAsBytes();
      request.files.add(http.MultipartFile.fromBytes('file', bytes, filename: file.path.split(Platform.pathSeparator).last));
      final streamed = await request.send();
      final resp = await http.Response.fromStream(streamed);
      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        final body = json.decode(resp.body) as Map<String, dynamic>;
        final secureUrl = body['secure_url'] as String?;
        if (secureUrl != null) urls.add(secureUrl);
      } else {
        throw Exception('Failed to upload image to Cloudinary: ${resp.statusCode} ${resp.body}');
      }
    }
    return urls;
  }
}
