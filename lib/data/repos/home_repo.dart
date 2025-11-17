import 'package:dartz/dartz.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';
import 'package:depi_final_project/core/errors/failures.dart';

abstract class HomeRepo {
  Future<Either<Failures, List<CategoryModel>>> fetchCategories();
  Future<Either<Failures, List<ProductModel>>> fetchProducts();
  Future<Either<Failures, List<ProductModel>>> fetchProductsByCategory(
    String categoryId,
  );
}
