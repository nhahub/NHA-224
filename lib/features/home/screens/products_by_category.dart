import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/data/models/product_model.dart';
import 'package:depi_final_project/core/widgets/app_bar_widget.dart';
import 'package:depi_final_project/features/home/cubit/home_cubit.dart';
import 'package:depi_final_project/features/store/cubit/fave_cubit.dart';
import 'package:depi_final_project/features/store/cubit/fave_state.dart';
import 'package:depi_final_project/features/store/screens/product_page.dart';
import 'package:depi_final_project/features/home/cubit/home_cubit_states.dart';
import 'package:depi_final_project/features/home/widgets/product_grid_widget.dart';

class ProductsByCategory extends StatelessWidget {
  const ProductsByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final categoryId = args?['categoryId'] as String? ?? '';
    final categoryName = args?['categoryName'] as String? ?? 'Products';

    // Load products filtered by category if categoryId is provided
    if (categoryId.isNotEmpty) {
      context.read<HomeCubit>().loadProductsByCategory(categoryId);
    }

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is HomeLoaded) {
          // For products by category, we would need to filter or load specific products
          // For now, display all products as placeholder
          final products = state.products;

          return Scaffold(
            appBar: CustomAppBar(title: categoryName),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explore $categoryName',
                      style: AppTextStyles.font17WiteRegular.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 16.sp,
                      ),
                    ),
                    verticalSpacing(24),

                    products.isNotEmpty
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: products.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16.w,
                                  mainAxisSpacing: 20.h,
                                  childAspectRatio: 3 / 4,
                                ),
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return _FavouriteGridItem(product: product);
                            },
                          )
                        : const Center(child: Text('No products available')),
                  ],
                ),
              ),
            ),
          );
        }

        return const Scaffold(
          body: Center(child: Text('Error loading products')),
        );
      },
    );
  }
}

class _FavouriteGridItem extends StatefulWidget {
  const _FavouriteGridItem({required this.product});

  final ProductModel product;

  @override
  State<_FavouriteGridItem> createState() => _FavouriteGridItemState();
}

class _FavouriteGridItemState extends State<_FavouriteGridItem> {
  late bool isFav;

  @override
  void initState() {
    super.initState();
    isFav = false;
    _loadFavouriteStatus();
  }

  Future<void> _loadFavouriteStatus() async {
    try {
      final fav = await context.read<FaveCubit>().isProductFavored(widget.product.id);
      if (mounted) {
        setState(() => isFav = fav);
      }
    } catch (e) {
      // Handle error, keep default false
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FaveCubit, FaveState>(
      listener: (context, state) {
        if (state is FaveToggled && state.product.id == widget.product.id) {
          setState(() => isFav = state.isFavored);
        }
      },
      child: ProductGridWidget(
        image: widget.product.imageUrl.isNotEmpty ? widget.product.imageUrl[0] : '',
        title: widget.product.name,
        price: '\$${widget.product.price.toStringAsFixed(2)}',
        oldPrice: widget.product.oldPrice != null
            ? '\$${widget.product.oldPrice!.toStringAsFixed(2)}'
            : null,
        isFavorite: isFav,
        onFavoritePressed: () {
          context.read<FaveCubit>().toggleFavoriteStatus(widget.product);
        },
        onTap: () {
          // Navigate to product details
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductPage(product: widget.product)),
          );
        },
      ),
    );
  }
}
