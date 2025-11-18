import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/theme/font_wieght.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/core/widgets/product_skeleton.dart';
import 'package:depi_final_project/features/store/cubit/store_cubit.dart';
import 'package:depi_final_project/features/store/cubit/store_state.dart';
import 'package:depi_final_project/features/store/widgets/filter_bottom.dart';
import 'package:depi_final_project/features/store/widgets/search_widget.dart';
import 'package:depi_final_project/features/store/widgets/Product_Widget.dart';
import 'package:depi_final_project/features/store/widgets/ShopByCatWidget.dart';
import 'package:depi_final_project/features/home/widgets/category_container.dart';
import 'package:depi_final_project/features/store/widgets/sort_bottom_sheet.dart';
import 'package:depi_final_project/features/store/widgets/deals_bottom_sheet.dart';
import 'package:depi_final_project/features/store/widgets/price_bottom_sheet.dart';
import 'package:depi_final_project/features/store/widgets/gender_bottom_sheet.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String currentQuery = '';
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    context.read<StoreCubit>().fetchCategories();
    context.read<StoreCubit>().fetchAllProducts();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),

            // Search Field
            SearchWidget(
              controller: controller,
              onChanged: (value) {
                setState(() => currentQuery = value);
                context.read<StoreCubit>().searchProducts(value);
              },
              onClear: () {
                controller.clear();
                setState(() => currentQuery = '');
                context.read<StoreCubit>().searchProducts('');
              },
            ),

            // Products / Categories
            Expanded(
              child: BlocBuilder<StoreCubit, StoreState>(
                builder: (context, state) {
                  List products = [];
                  final hasFilters =
                      context.read<StoreCubit>().sort != 'Recommended' ||
                      context.read<StoreCubit>().selectedGenders.isNotEmpty ||
                      context.read<StoreCubit>().onSale ||
                      context.read<StoreCubit>().freeShipping ||
                      context.read<StoreCubit>().minPriceSel != null ||
                      context.read<StoreCubit>().maxPriceSel != null;
                  bool showCategories = controller.text.isEmpty && !hasFilters;

                  if (state is StoreLoading) {
                    return const ProductSkeleton();
                  }
                  if (state is StoreError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is StoreProductsLoaded) {
                    products = state.products;
                  }

                  return ListView(
                    children: [
                      // Show categories when no search is performed
                      if (showCategories)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpacing(24),
                            Text(
                              'Shop by Categories',
                              style: AppTextStyles.font20WitekBold.copyWith(
                                fontSize: 24.sp,
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            BlocBuilder<StoreCubit, StoreState>(
                              builder: (context, state) {
                                if (state is StoreCategoriesLoaded) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.categories.length,
                                    itemBuilder: (context, index) {
                                      final category = state.categories[index];
                                      return CategoryContainerItem(
                                        image: category.imageUrl,
                                        label: category.name,
                                        categoryId: category.id,
                                      );
                                    },
                                  );
                                } else if (state is StoreLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  // Fallback: show empty state or default categories
                                  return const Center(
                                    child: Text('No categories available'),
                                  );
                                }
                              },
                            ),
                          ],
                        ),

                      // Show filters and search results
                      if (!showCategories)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Top filter bar
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Wrap(
                                    spacing: 8,
                                    children: [
                                      FilterChip(
                                        label: const Text('Sort by'),
                                        selected:
                                            context.read<StoreCubit>().sort !=
                                            'Recommended',
                                        color: MaterialStateProperty.all(
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                        ),
                                        labelStyle: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSecondary,
                                        ),
                                        onSelected: (_) {

                                          if (context.read<StoreCubit>().sort != 'Recommended') {

                                            context.read<StoreCubit>().updateSort('Recommended');

                                          } else {

                                            showModalBottomSheet(

                                              context: context,

                                              backgroundColor: Colors.transparent,

                                              builder: (_) => const SortBottomSheet(),

                                            );

                                          }

                                        },
                                      ),
                                      FilterChip(
                                        label: const Text('Gender'),
                                        selected: context
                                            .read<StoreCubit>()
                                            .selectedGenders
                                            .isNotEmpty,
                                        color: MaterialStateProperty.all(
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                        ),
                                        labelStyle: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSecondary,
                                        ),
                                        onSelected: (_) {
                                          if (context.read<StoreCubit>().selectedGenders.isNotEmpty) {
                                            context.read<StoreCubit>().updateGenders([]);
                                          } else {
                                            showModalBottomSheet(
                                              context: context,
                                              backgroundColor: Colors.transparent,
                                              builder: (_) => const GenderBottomSheet(),
                                            );
                                          }
                                        },
                                      ),
                                      FilterChip(
                                        label: const Text('Deals'),
                                        selected:
                                            context.read<StoreCubit>().onSale ||
                                            context
                                                .read<StoreCubit>()
                                                .freeShipping,
                                        color: MaterialStateProperty.all(
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                        ),
                                        labelStyle: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSecondary,
                                        ),
                                        onSelected: (_) {

                                          if (context.read<StoreCubit>().onSale || context.read<StoreCubit>().freeShipping) {

                                            context.read<StoreCubit>().updateDeals(false, false);

                                          } else {

                                            showModalBottomSheet(

                                              context: context,

                                              backgroundColor: Colors.transparent,

                                              builder: (_) => const DealsBottomSheet(),

                                            );

                                          }

                                        },
                                      ),
                                      FilterChip(
                                        label: const Text('Price'),
                                        selected:
                                            context
                                                    .read<StoreCubit>()
                                                    .minPriceSel !=
                                                null ||
                                            context
                                                    .read<StoreCubit>()
                                                    .maxPriceSel !=
                                                null,
                                        color: MaterialStateProperty.all(
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                        ),
                                        labelStyle: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSecondary,
                                        ),
                                        onSelected: (_) {

                                          if (context.read<StoreCubit>().minPriceSel != null || context.read<StoreCubit>().maxPriceSel != null) {

                                            context.read<StoreCubit>().updatePrice(null, null);

                                          } else {

                                            showModalBottomSheet(

                                              context: context,

                                              backgroundColor: Colors.transparent,

                                              builder: (_) => const PriceBottomSheet(),

                                            );

                                          }

                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '${products.length} Results Found',
                              style: AppTextStyles.labelLarge.copyWith(
                                fontSize: 16.sp,
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            products.isNotEmpty
                                ? GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.only(top: 16),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 16,
                                          crossAxisSpacing: 16,
                                          childAspectRatio: 0.56,
                                        ),
                                    itemCount: products.length,
                                    itemBuilder: (context, index) {
                                      print(index);
                                      final product = products[index];
                                      return ProductWidgetSearch(
                                        onTap: () {
                                          print("product: " + product.name);
                                          Navigator.pushNamed(
                                            context,
                                            AppRoutes.productDetails,
                                            arguments: product,
                                          );
                                        },
                                        imageUrl: product.imageUrl[0],
                                        title: product.name,
                                        price:
                                            "\$${product.price.toStringAsFixed(2)}",
                                        oldPrice: product.oldPrice != null
                                            ? "\$${product.oldPrice!.toStringAsFixed(2)}"
                                            : null,
                                      );
                                    },
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Sorry, we couldn't find any matching result for your Search.",
                                            ),
                                            Text("Explore Categories"),
                                          ],
                                        ),
                                      ),
                                      // Show categories here, similar to no search
                                      BlocBuilder<StoreCubit, StoreState>(
                                        builder: (context, state) {
                                          if (state is StoreCategoriesLoaded) {
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  state.categories.length,
                                              itemBuilder: (context, index) {
                                                final category =
                                                    state.categories[index];
                                                return CategoryContainerItem(
                                                  image: category.imageUrl,
                                                  label: category.name,
                                                  categoryId: category.id,
                                                );
                                              },
                                            );
                                          } else if (state is StoreLoading) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else {
                                            return const Center(
                                              child: Text(
                                                'No categories available',
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                          ],
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
