import 'package:depi_final_project/data/models/product_model.dart';
import 'package:depi_final_project/data/models/category_model.dart';

abstract class StoreState {}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreCategoriesLoaded extends StoreState {
  final List<CategoryModel> categories;
  StoreCategoriesLoaded(this.categories);
}

class StoreProductsLoaded extends StoreState {
  final List<ProductModel> products;
  StoreProductsLoaded(this.products);
}

class StoreError extends StoreState {
  final String message;
  StoreError(this.message);
}
