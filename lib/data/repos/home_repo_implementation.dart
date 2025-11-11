import 'home_repo.dart';
import 'package:dartz/dartz.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';
import '../sources/firebase_service.dart';
import 'package:depi_final_project/core/errors/failures.dart';


class HomeRepoImplementation implements HomeRepo {
  final FirebaseService firebaseService;

  HomeRepoImplementation({required this.firebaseService});

  @override
  Future<Either<Failures, List<Category>>> fetchCategories() async {
    try {
      final categories = await firebaseService.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(e.toString(), errorMessage: 'Failed to fetch categories'));
    }
  }

  @override
  Future<Either<Failures, List<ProductModel>>> fetchProducts() async {
    try {
      final products = await firebaseService.getProducts();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure(e.toString(), errorMessage: 'Failed to fetch products'));
    }
  }

  @override
  Future<Either<Failures, List<ProductModel>>> fetchProductsByCategory(String categoryId) async {
    try {
      final products = await firebaseService.getProductsByCategory(categoryId);
      return Right(products);
    } catch (e) {
      return Left(ServerFailure(e.toString(), errorMessage: 'Failed to fetch products by category'));
    }
  }
}
