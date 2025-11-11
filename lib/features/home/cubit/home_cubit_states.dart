import 'package:depi_final_project/data/models/product_model.dart';
import 'package:depi_final_project/data/models/category_model.dart';



abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState {
  final List<Category> categories;
  final List<ProductModel> products;

  HomeLoaded({required this.categories, required this.products});
}
class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}