import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/widgets/app_bar_widget.dart';
import 'package:depi_final_project/features/home/cubit/home_cubit.dart';
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
                              return ProductGridWidget(
                                image: product.imageUrl.isNotEmpty
                                    ? product.imageUrl[0]
                                    : '',
                                title: product.name,
                                price: '\$${product.price.toStringAsFixed(2)}',
                                oldPrice: product.oldPrice != null
                                    ? '\$${product.oldPrice!.toStringAsFixed(2)}'
                                    : null,
                                isFavorite: false,
                                onTap: () {
                                  // Navigate to product details
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ProductPage(),
                                    ),
                                  );
                                },
                              );
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
