import 'package:flutter/foundation.dart';
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
  String _sort =
      'Recommended'; // "Recommended" أو "Newest" أو "Lowest Price" أو "Highest Price"

  // getters علشان نقدر نعرض القيم في الزرار
  double? get minPriceSel => _minPriceSel;
  double? get maxPriceSel => _maxPriceSel;
  List<String> get selectedGenders => _selectedGenders;
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
    emit(StoreLoading());
    final result = await homeRepo.fetchProducts();
    result.fold(
      (failure) {
        emit(StoreError(failure.errorMessage));
      },
      (products) {
        _allProducts = products;
        // initialize filtered products with all products on first fetch
        applyAll();
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

  /// Apply search and filters together
  /// Handles null safety and empty results
  void _applySearchAndFilters() {
    try {
      // If no search query, show categories or apply filters only
      if (_lastQuery.isEmpty) {
        if (!_hasActiveFilters()) {
          emit(StoreCategoriesLoaded(_categories));
        } else {
          _applyFilters();
        }
        return;
      }

      // Filter products by search query and active filters
      _filteredProducts = _allProducts.where((p) {
        try {
          final matchQuery = p.name.toLowerCase().contains(
            _lastQuery.toLowerCase(),
          );
          return matchQuery && _matchesFilters(p);
        } catch (e) {
          debugPrint('Error filtering product ${p.id}: $e');
          return false;
        }
      }).toList();

      _sortProducts();
      emit(StoreProductsLoaded(_filteredProducts));
    } catch (e) {
      debugPrint('Error in _applySearchAndFilters: $e');
      emit(StoreError('Failed to apply search: ${e.toString()}'));
    }
  }

  /// Search for products by query
  /// Handles cases where products need to be fetched first
  Future<void> searchProducts(String query) async {
    try {
      _lastQuery = query.trim();

      // If products not loaded yet, fetch them first (fetchAllProducts will emit loading)
      if (_allProducts.isEmpty) {
        await fetchAllProducts();
      } else {
        // Products already loaded, apply search
        _applySearchAndFilters();
      }
    } catch (e) {
      debugPrint('Error in searchProducts: $e');
      emit(StoreError('Search failed: ${e.toString()}'));
    }
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

  /// Apply filters only (no search query)
  void _applyFilters() {
    try {
      _filteredProducts = _allProducts.where((p) {
        try {
          return _matchesFilters(p);
        } catch (e) {
          debugPrint('Error filtering product ${p.id}: $e');
          return false;
        }
      }).toList();

      _sortProducts();
      emit(StoreProductsLoaded(_filteredProducts));
    } catch (e) {
      debugPrint('Error in _applyFilters: $e');
      emit(StoreError('Failed to apply filters: ${e.toString()}'));
    }
  }

  bool _hasActiveFilters() {
    return _sort != 'Recommended' ||
        _selectedGenders.isNotEmpty ||
        _minPriceSel != null ||
        _maxPriceSel != null;
  }

  // getters for backward compatibility
  double get minPrice => _minPriceSel ?? 0.0;
  double get maxPrice => _maxPriceSel ?? double.infinity;
  String get gender => _selectedGenders.join(', ');

  /// Check if product matches all active filters
  /// Safely handles null values and type conversions
  bool _matchesFilters(ProductModel p) {
    try {
      // Gender filter - case insensitive
      if (_selectedGenders.isNotEmpty) {
        final productGender = p.gender.toLowerCase().trim();
        final hasMatchingGender = _selectedGenders.any(
          (g) => g.toLowerCase().trim() == productGender,
        );
        if (!hasMatchingGender) return false;
      }

      // Price filter - minimum
      if (_minPriceSel != null && _minPriceSel! > 0) {
        try {
          if (p.price < _minPriceSel!) return false;
        } catch (e) {
          debugPrint('Error comparing min price: $e');
          return false;
        }
      }

      // Price filter - maximum
      if (_maxPriceSel != null && _maxPriceSel! > 0) {
        try {
          if (p.price > _maxPriceSel!) return false;
        } catch (e) {
          debugPrint('Error comparing max price: $e');
          return false;
        }
      }

      return true;
    } catch (e) {
      debugPrint('Error in _matchesFilters: $e');
      return false;
    }
  }

  /// Sort filtered products based on current sort preference
  /// Handles null safety for dates and prices
  void _sortProducts() {
    try {
      if (_filteredProducts.isEmpty) return;

      switch (_sort) {
        case 'Newest':
          try {
            _filteredProducts.sort((a, b) {
              final dateA = a.createdAt;
              final dateB = b.createdAt;
              if (dateA == null || dateB == null) return 0;
              return dateB.compareTo(dateA);
            });
          } catch (e) {
            debugPrint('Error sorting by newest: $e');
          }
          break;

        case 'Lowest Price':
          try {
            _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
          } catch (e) {
            debugPrint('Error sorting by lowest price: $e');
          }
          break;

        case 'Highest Price':
          try {
            _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
          } catch (e) {
            debugPrint('Error sorting by highest price: $e');
          }
          break;

        case 'Recommended':
        default:
          // No sorting applied
          break;
      }
    } catch (e) {
      debugPrint('Error in _sortProducts: $e');
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

  void updatePrice(double? min, double? max) {
    _minPriceSel = min;
    _maxPriceSel = max;
    applyAll();
  }

  /// Apply all filters and search together
  /// Main entry point for filter updates
  void applyAll() {
    try {
      if (_lastQuery.isEmpty) {
        if (!_hasActiveFilters()) {
          emit(StoreCategoriesLoaded(_categories));
        } else {
          _applyFilters();
        }
      } else {
        _applySearchAndFilters();
      }
    } catch (e) {
      debugPrint('Error in applyAll: $e');
      emit(StoreError('Failed to apply filters: ${e.toString()}'));
    }
  }
}
