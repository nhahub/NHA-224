import 'dart:io';
import 'dart:convert';
import '../models/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  final FirebaseFirestore _db;
  final String? cloudinaryCloudName;
  final String? cloudinaryUploadPreset;

  CategoryService({
    FirebaseFirestore? firestore,
    this.cloudinaryCloudName,
    this.cloudinaryUploadPreset,
  }) : _db = firestore ?? FirebaseFirestore.instance;

  Future<String> addCategory(CategoryModel model, {File? imageFile}) async {
    final docRef = _db.collection('categories').doc();
    try {
      String imageUrl = model.imageUrl;
      if (imageFile != null) {
        if (cloudinaryCloudName != null && cloudinaryUploadPreset != null) {
          final uploaded = await _uploadFileToCloudinary(imageFile);
          imageUrl = uploaded;
        } else {
          throw Exception(
            'Cloudinary configuration missing for category image upload',
          );
        }
      }

      final data = model
          .copyWith(
            id: docRef.id,
            imageUrl: imageUrl,
            createdAt: model.createdAt,
          )
          .toMap();
      await docRef.set(data);
      return docRef.id;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCategory(
    String id,
    CategoryModel model, {
    File? imageFile,
  }) async {
    final docRef = _db.collection('categories').doc(id);
    try {
      String imageUrl = model.imageUrl;
      if (imageFile != null) {
        if (cloudinaryCloudName != null && cloudinaryUploadPreset != null) {
          final uploaded = await _uploadFileToCloudinary(imageFile);
          imageUrl = uploaded;
        } else {
          throw Exception(
            'Cloudinary configuration missing for category image upload',
          );
        }
      }
      final data = model.copyWith(imageUrl: imageUrl).toMap();
      await docRef.update(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCategory(String id) async {
    final docRef = _db.collection('categories').doc(id);
    try {
      final doc = await docRef.get();
      if (doc.exists) {
        // Deleting Cloudinary assets requires server-side API key/secret; here we remove Firestore doc only.
        await docRef.delete();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final snap = await _db.collection('categories').orderBy('createdAt').get();
    return snap.docs.map((d) => CategoryModel.fromFirestore(d)).toList();
  }

  Stream<List<CategoryModel>> categoriesStream() {
    return _db
        .collection('categories')
        .orderBy('createdAt')
        .snapshots()
        .map((s) => s.docs.map((d) => CategoryModel.fromFirestore(d)).toList());
  }

  Future<String> _uploadFileToCloudinary(File file) async {
    if (cloudinaryCloudName == null || cloudinaryUploadPreset == null) {
      throw Exception('Cloudinary configuration missing');
    }
    final uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudinaryCloudName/image/upload',
    );
    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = cloudinaryUploadPreset!;
    final bytes = await file.readAsBytes();
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: file.path.split(Platform.pathSeparator).last,
      ),
    );
    final streamed = await request.send();
    final resp = await http.Response.fromStream(streamed);
    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      final body = json.decode(resp.body) as Map<String, dynamic>;
      final secureUrl = body['secure_url'] as String?;
      if (secureUrl != null) return secureUrl;
      throw Exception('Cloudinary upload succeeded but secure_url missing');
    }
    throw Exception(
      'Failed to upload category image to Cloudinary: ${resp.statusCode} ${resp.body}',
    );
  }
}
