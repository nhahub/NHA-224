import 'dart:io';
import '../models/category_model.dart';
import '../services/category_service.dart';

abstract class CategoryRepo {
  Future<String> addCategory(CategoryModel category, {File? imageFile});
  Future<void> updateCategory(
    String id,
    CategoryModel category, {
    File? imageFile,
  });
  Future<void> deleteCategory(String id);
  Future<List<CategoryModel>> fetchCategories();
}

class CategoryRepoImpl implements CategoryRepo {
  final CategoryService _service;
  CategoryRepoImpl(this._service);

  @override
  Future<String> addCategory(CategoryModel category, {File? imageFile}) =>
      _service.addCategory(category, imageFile: imageFile);

  @override
  Future<void> updateCategory(
    String id,
    CategoryModel category, {
    File? imageFile,
  }) => _service.updateCategory(id, category, imageFile: imageFile);

  @override
  Future<void> deleteCategory(String id) => _service.deleteCategory(id);

  @override
  Future<List<CategoryModel>> fetchCategories() => _service.getAllCategories();
}
