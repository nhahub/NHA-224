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
  String _lastQuery = '';

  // القيم الحالية للفلاتر
  double? _minPriceSel;
  double? _maxPriceSel;
  List<String> _selectedGenders = [];
  bool _onSale = false;
  bool _freeShipping = false;
  String _sort =
      'Recommended'; // "Recommended" أو "Newest" أو "Lowest Price" أو "Highest Price"

  // getters علشان نقدر نعرض القيم في الزرار
  double? get minPriceSel => _minPriceSel;
  double? get maxPriceSel => _maxPriceSel;
  List<String> get selectedGenders => _selectedGenders;
  bool get onSale => _onSale;
  bool get freeShipping => _freeShipping;
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

  // جلب جميع المنتجات للبحث
  Future<void> fetchAllProducts() async {
    final result = await homeRepo.fetchProducts();
    result.fold(
      (failure) {
        emit(StoreError(failure.errorMessage));
      },
      (products) {
        _allProducts = products;
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

  // تطبيق البحث والفلاتر
  void _applySearchAndFilters() {
    if (_lastQuery.isEmpty) {
      emit(StoreCategoriesLoaded(_categories));
      return;
    }
    _filteredProducts = _allProducts.where((p) {
      final matchQuery = p.name.toLowerCase().contains(
        _lastQuery.toLowerCase(),
      );
      return matchQuery && _matchesFilters(p);
    }).toList();

    _sortProducts();
    emit(StoreProductsLoaded(_filteredProducts));
  }

  // البحث
  void searchProducts(String query) {
    if (query.isEmpty) {
      _lastQuery = query;
      _applySearchAndFilters();
      return;
    }
    _lastQuery = query;
    _applySearchAndFilters();
  }

  // تحديث الفلاتر
  void updateFilters({double? minPrice, double? maxPrice, String? sort}) {
    _minPriceSel = minPrice ?? _minPriceSel;
    _maxPriceSel = maxPrice ?? _maxPriceSel;
    _sort = sort ?? _sort;

    if (_lastQuery.isNotEmpty) {
      _applySearchAndFilters();
    } else {
      _applyFilters();
    }
  }

  // تطبيق الفلاتر على المنتجات بدون بحث
  void _applyFilters() {
    _filteredProducts = _allProducts.where(_matchesFilters).toList();
    _sortProducts();
    emit(StoreProductsLoaded(_filteredProducts));
  }

  // getters for backward compatibility
  double get minPrice => _minPriceSel ?? 0.0;
  double get maxPrice => _maxPriceSel ?? double.infinity;
  String get gender => _selectedGenders.join(', ');

  // تحقق من الفلاتر لكل منتج
  bool _matchesFilters(ProductModel p) {
    bool matches = true;
    if (_selectedGenders.isNotEmpty && !_selectedGenders.contains(p.gender))
      matches = false;
    if (_onSale && !(p.oldPrice != null && p.price < p.oldPrice!))
      matches = false;
    // if (_freeShipping) matches = false; // assume not for now
    if (_minPriceSel != null) matches &= p.price >= _minPriceSel!;
    if (_maxPriceSel != null) matches &= p.price <= _maxPriceSel!;
    return matches;
  }

  // ترتيب المنتجات
  void _sortProducts() {
    switch (_sort) {
      case 'Newest':
        _filteredProducts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 'Lowest Price':
        _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Highest Price':
        _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Recommended':
      default:
        // no sort
        break;
    }
  }

  // new methods
  void updateSort(String sort) {
    _sort = sort;
    applyAll();
  }

  void updateGenders(List<String> genders) {
    _selectedGenders = genders;
    applyAll();
  }

  void updateDeals(bool onSale, bool freeShipping) {
    _onSale = onSale;
    _freeShipping = freeShipping;
    applyAll();
  }

  void updatePrice(double? min, double? max) {
    _minPriceSel = min;
    _maxPriceSel = max;
    applyAll();
  }

  void applyAll() {
    _lastQuery.isEmpty ? _applyFilters() : _applySearchAndFilters();
  }
}
