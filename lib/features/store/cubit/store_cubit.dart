import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depi_final_project/data/repos/home_repo.dart';
import 'package:depi_final_project/data/models/product_model.dart';
import 'package:depi_final_project/data/models/category_model.dart';
import 'package:depi_final_project/features/store/cubit/store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  final HomeRepo homeRepo;
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;
  List<ProductModel> _allProducts = [];
  List<ProductModel> _filteredProducts = [];

  // القيم الحالية للفلاتر
  double? _minPrice;
  double? _maxPrice;
  String? _gender;
  String? _sort; // "Newest" أو "Oldest"

  // getters علشان نقدر نعرض القيم في الزرار
  double? get minPrice => _minPrice;
  double? get maxPrice => _maxPrice;
  String? get gender => _gender;
  String? get sort => _sort;

  StoreCubit(this.homeRepo) : super(StoreInitial());

  // جلب الكاتجوريز
  Future<void> fetchCategories() async {
    emit(StoreLoading());
    final result = await homeRepo.fetchCategories();
    result.fold(
      (failure) {
        emit(StoreError(failure.errorMessage));
      },
      (cats) {
        _categories = cats;
        emit(StoreCategoriesLoaded(cats));
      },
    );
  }

  // جلب المنتجات حسب الكاتجوري
  Future<void> fetchProductsByCategory(String categoryId) async {
    emit(StoreLoading());
    final result = await homeRepo.fetchProductsByCategory(categoryId);
    result.fold(
      (failure) {
        emit(StoreError(failure.errorMessage));
      },
      (products) {
        _allProducts = products;
        _applyFilters();
      },
    );
  }

  // البحث
  void searchProducts(String query) {
    _filteredProducts = _allProducts.where((p) {
      final matchQuery =
          query.isEmpty || p.name.toLowerCase().contains(query.toLowerCase());
      return matchQuery && _matchesFilters(p);
    }).toList();

    _sortProducts();
    emit(StoreProductsLoaded(_filteredProducts));
  }

  // تحديث الفلاتر
  void updateFilters({
    double? minPrice,
    double? maxPrice,
    String? gender,
    String? sort,
  }) {
    _minPrice = minPrice ?? _minPrice;
    _maxPrice = maxPrice ?? _maxPrice;
    _gender = gender ?? _gender;
    _sort = sort ?? _sort;

    _applyFilters();
  }

  // تطبيق الفلاتر على المنتجات
  void _applyFilters() {
    _filteredProducts = _allProducts.where(_matchesFilters).toList();
    _sortProducts();
    emit(StoreProductsLoaded(_filteredProducts));
  }

  // تحقق من الفلاتر لكل منتج
  bool _matchesFilters(ProductModel p) {
    bool matches = true;
    if (_minPrice != null) matches &= p.price >= _minPrice!;
    if (_maxPrice != null) matches &= p.price <= _maxPrice!;
    if (_gender != null) matches &= p.gender == _gender;
    return matches;
  }

  // ترتيب المنتجات
  void _sortProducts() {
    if (_sort == "Newest") {
      _filteredProducts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else if (_sort == "Oldest") {
      _filteredProducts.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }
  }
}
