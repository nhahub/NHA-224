import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depi_final_project/data/repos/home_repo.dart';
import 'package:depi_final_project/features/home/cubit/home_cubit_states.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  HomeCubit({required this.homeRepo}) : super(HomeInitial());

  Future<void> loadHome() async {
    emit(HomeLoading());
    try {
      final categoriesResult = await homeRepo.fetchCategories();
      final productsResult = await homeRepo.fetchProducts();

      categoriesResult.fold(
        (failure) => emit(HomeError(failure.toString())),
        (categories) {
          productsResult.fold(
            (failure) => emit(HomeError(failure.toString())),
            (products) => emit(HomeLoaded(categories: categories, products: products)),
          );
        },
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> loadProductsByCategory(String categoryId) async {
    emit(HomeLoading());
    try {
      final categoriesResult = await homeRepo.fetchCategories();
      final productsResult = await homeRepo.fetchProductsByCategory(categoryId);

      categoriesResult.fold(
        (failure) => emit(HomeError(failure.toString())),
        (categories) {
          productsResult.fold(
            (failure) => emit(HomeError(failure.toString())),
            (products) => emit(HomeLoaded(categories: categories, products: products)),
          );
        },
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
