import 'dart:io';
import '../models/product_model.dart';
import '../services/product_service.dart';

abstract class ProductRepo {
  Future<String> addProduct(ProductModel product, {List<File>? imageFiles});
  Future<void> updateProduct(
    String id,
    ProductModel product, {
    List<File>? imageFilesToAdd,
    List<String>? imageUrlsToRemove,
  });
  Future<void> deleteProduct(String id);
  Future<ProductModel?> fetchProductById(String id);
  Future<List<ProductModel>> fetchProducts();
  Future<List<ProductModel>> fetchProductsByCategory(String categoryId);
}

class ProductRepoImpl implements ProductRepo {
  final ProductService _service;
  ProductRepoImpl(this._service);

  @override
  Future<String> addProduct(ProductModel product, {List<File>? imageFiles}) {
    return _service.addProduct(product, imageFiles: imageFiles);
  }

  @override
  Future<void> updateProduct(
    String id,
    ProductModel product, {
    List<File>? imageFilesToAdd,
    List<String>? imageUrlsToRemove,
  }) {
    return _service.updateProduct(
      id,
      product,
      imageFilesToAdd: imageFilesToAdd,
      imageUrlsToRemove: imageUrlsToRemove,
    );
  }

  @override
  Future<void> deleteProduct(String id) => _service.deleteProduct(id);

  @override
  Future<ProductModel?> fetchProductById(String id) =>
      _service.getProductById(id);

  @override
  Future<List<ProductModel>> fetchProducts() => _service.getAllProducts();

  @override
  Future<List<ProductModel>> fetchProductsByCategory(String categoryId) =>
      _service.getProductsByCategory(categoryId);
}
