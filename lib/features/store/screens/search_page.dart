import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/core/widgets/product_skeleton.dart';
import 'package:depi_final_project/core/navigation/route_observer.dart';
import 'package:depi_final_project/features/store/cubit/store_cubit.dart';
import 'package:depi_final_project/features/store/cubit/store_state.dart';
import 'package:depi_final_project/features/store/widgets/search_widget.dart';
import 'package:depi_final_project/features/store/widgets/Product_Widget.dart';
import 'package:depi_final_project/features/store/widgets/sort_bottom_sheet.dart';
import 'package:depi_final_project/features/home/widgets/category_container.dart';
import 'package:depi_final_project/features/store/widgets/price_bottom_sheet.dart';
import 'package:depi_final_project/features/store/widgets/gender_bottom_sheet.dart';

// Constants
const Duration _kDebounceDuration = Duration(milliseconds: 400);
const double _kFilterChipHeight = 52.0;
const double _kGridAspectRatio = 0.55;
const int _kGridCrossAxisCount = 2;

// Filter Bar Widget
class _FilterBar extends StatelessWidget {
  final StoreCubit cubit;

  const _FilterBar({required this.cubit});

  String _sortLabel(String? sort) {
    if (sort == null || sort == 'Recommended') return 'Sort by';
    if (sort == 'Lowest Price') return 'Lowest - Highest Price';
    if (sort == 'Highest Price') return 'Highest - Lowest Price';
    return sort;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _kFilterChipHeight.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4.h),
        children: [
          FilterChip(
            label: Text(_sortLabel(cubit.sort)),
            selected: cubit.sort != 'Recommended',
            color: MaterialStateProperty.all(
              Theme.of(context).colorScheme.secondary,
            ),
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            onSelected: (_) {
              if (cubit.sort != 'Recommended') {
                cubit.updateSort('Recommended');
              } else {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const SortBottomSheet(),
                );
              }
            },
          ),
          SizedBox(width: 8.w),
          FilterChip(
            label: const Text('Gender'),
            selected: cubit.selectedGenders.isNotEmpty,
            color: MaterialStateProperty.all(
              Theme.of(context).colorScheme.secondary,
            ),
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            onSelected: (_) {
              if (cubit.selectedGenders.isNotEmpty) {
                cubit.updateGenders([]);
              } else {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const GenderBottomSheet(),
                );
              }
            },
          ),
          SizedBox(width: 8.w),
          FilterChip(
            label: const Text('Price'),
            selected: cubit.minPriceSel != null || cubit.maxPriceSel != null,
            color: MaterialStateProperty.all(
              Theme.of(context).colorScheme.secondary,
            ),
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            onSelected: (_) {
              if (cubit.minPriceSel != null || cubit.maxPriceSel != null) {
                cubit.updatePrice(null, null);
              } else {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (_) => const PriceBottomSheet(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with RouteAware {
  String currentQuery = '';
  late TextEditingController controller;
  Timer? _debounce;
  bool _initialized = false;
  bool _isDisposed = false;
  late StoreCubit _storeCubit;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try {
      _storeCubit = context.read<StoreCubit>();
      final ModalRoute? route = ModalRoute.of(context);
      if (route is PageRoute) {
        routeObserver.subscribe(this, route);
      }

      if (!_initialized) {
        _initializeSearch();
        _initialized = true;
      }
    } catch (e) {
      debugPrint('Error in didChangeDependencies: $e');
      if (mounted) _showErrorSnackbar('Failed to initialize search');
    }
  }

  void _initializeSearch() {
    try {
      final args = ModalRoute.of(context)?.settings.arguments;

      if (args is String && args.isNotEmpty) {
        currentQuery = args;
        controller.text = args;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!_isDisposed && mounted) {
            _storeCubit.searchProducts(args);
          }
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!_isDisposed && mounted) {
            _storeCubit.fetchCategories();
            _storeCubit.fetchAllProducts();
          }
        });
      }
    } catch (e) {
      debugPrint('Error initializing search: $e');
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    try {
      _debounce?.cancel();
      _resetSearchState(false);
      controller.dispose();
      try {
        routeObserver.unsubscribe(this);
      } catch (_) {}
    } catch (e) {
      debugPrint('Error during dispose: $e');
    }
    super.dispose();
  }

  @override
  void didPopNext() {
    try {
      if (_isDisposed) return;

      final storeCubit = _storeCubit;
      if (storeCubit.categories.isEmpty) {
        storeCubit.fetchCategories();
      }
      storeCubit.fetchAllProducts();

      if (mounted) setState(() {});
    } catch (e) {
      debugPrint('Error in didPopNext: $e');
    }
  }

  void _resetSearchState([bool updateState = true]) {
    try {
      _debounce?.cancel();
      controller.clear();

      if (updateState && mounted) {
        setState(() => currentQuery = '');
      } else {
        currentQuery = '';
      }

      try {
        _storeCubit.searchProducts('');
        _storeCubit.updateSort('Recommended');
        _storeCubit.updateGenders([]);
        _storeCubit.updatePrice(null, null);
      } catch (e) {
        debugPrint('Error resetting cubit state: $e');
      }
    } catch (e) {
      debugPrint('Error resetting search state: $e');
    }
  }

  void _showErrorSnackbar(String message) {
    try {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      }
    } catch (e) {
      debugPrint('Error showing snackbar: $e');
    }
  }

  String _sortLabel(String? sort) {
    if (sort == null || sort == 'Recommended') return 'Sort by';
    if (sort == 'Lowest Price') return 'Lowest - Highest Price';
    if (sort == 'Highest Price') return 'Highest - Lowest Price';
    return sort;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),

            SearchWidget(
              controller: controller,
              onChanged: (value) {
                try {
                  if (mounted) setState(() => currentQuery = value);

                  _debounce?.cancel();
                  _debounce = Timer(_kDebounceDuration, () {
                    if (!_isDisposed && mounted) {
                      _storeCubit.searchProducts(value);
                    }
                  });
                } catch (e) {
                  debugPrint('Error on search input change: $e');
                }
              },
              onClear: () {
                try {
                  controller.clear();
                  if (mounted) setState(() => currentQuery = '');
                  _debounce?.cancel();
                  if (!_isDisposed && mounted) {
                    _storeCubit.searchProducts('');
                  }
                } catch (e) {
                  debugPrint('Error clearing search: $e');
                }
              },
            ),

            // Products / Categories
            Expanded(
              child: BlocBuilder<StoreCubit, StoreState>(
                builder: (context, state) {
                  // Initial explore UI when categories are loaded and no search
                  if (state is StoreCategoriesLoaded) {
                    final cats = state.categories;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.h),
                        Text(
                          'Explore',
                          style: AppTextStyles.font20WitekBold.copyWith(
                            fontSize: 22.sp,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Find products by category',
                          style: AppTextStyles.labelLarge.copyWith(
                            fontSize: 14.sp,
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Expanded(
                          child: cats.isNotEmpty
                              ? ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: cats.length,
                                  itemBuilder: (context, index) {
                                    final c = cats[index];
                                    return CategoryContainerItem(
                                      image: c.imageUrl,
                                      label: c.name,
                                      categoryId: c.id,
                                    );
                                  },
                                )
                              : Center(
                                  child: Text(
                                    'No categories available',
                                    style: AppTextStyles.labelLarge.copyWith(
                                      fontSize: 16.sp,
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    );
                  }

                  List products = [];

                  if (state is StoreLoading) return const ProductSkeleton();
                  if (state is StoreError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 48),
                          const SizedBox(height: 16),
                          Text(state.message),
                        ],
                      ),
                    );
                  }
                  if (state is StoreProductsLoaded) products = state.products;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top filter bar - horizontal scrollable
                      _FilterBar(cubit: _storeCubit),
                      SizedBox(height: 16.h),
                      Text(
                        '${products.length} Results Found',
                        style: AppTextStyles.labelLarge.copyWith(
                          fontSize: 16.sp,
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: products.isNotEmpty
                            ? GridView.builder(
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 0,
                                ),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: _kGridCrossAxisCount,
                                  mainAxisSpacing: 12.h,
                                  crossAxisSpacing: 12.w,
                                  childAspectRatio: _kGridAspectRatio,
                                ),
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  final product = products[index];
                                  return ProductWidgetSearch(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.productDetails,
                                        arguments: product,
                                      );
                                    },
                                    imageUrl: product.imageUrl[0],
                                    title: product.name,
                                    price: "\$${product.price.toStringAsFixed(2)}",
                                    oldPrice: product.oldPrice != null
                                        ? "\$${product.oldPrice!.toStringAsFixed(2)}"
                                        : null,
                                  );
                                },
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search_off,
                                      size: 80.sp,
                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                    ),
                                    SizedBox(height: 16.h),
                                    Text(
                                      "No results found",
                                      style: AppTextStyles.font20WitekBold.copyWith(
                                        fontSize: 20.sp,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      "Try adjusting your search or filters",
                                      style: AppTextStyles.labelLarge.copyWith(
                                        fontSize: 14.sp,
                                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
