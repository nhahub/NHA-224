import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/features/store/cubit/store_cubit.dart';
import 'package:depi_final_project/features/store/cubit/store_state.dart';
import 'package:depi_final_project/features/store/widgets/Product_Widget.dart';
import 'package:depi_final_project/features/store/widgets/ShopByCatWidget.dart';
import 'package:depi_final_project/features/store/widgets/filter_bottom.dart';
import 'package:depi_final_project/features/store/widgets/filter_bottom_sheat.dart';
// import 'package:depi_final_project/features/store/widgets/filter_bottom.dart';
// import 'package:depi_final_project/features/store/widgets/filter_bottom_sheat.dart';
import 'package:depi_final_project/features/store/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<StoreCubit>().fetchCategories();

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),

            // Search Field
            SearchWidget(
              onChanged: (query) {
                context.read<StoreCubit>().searchProducts(query);
              },
              onClear: () {
                context.read<StoreCubit>().searchProducts('');
              },
            ),
            const SizedBox(height: 16),

            // Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterButton(
                    title:
                        context.read<StoreCubit>().minPrice != null ||
                            context.read<StoreCubit>().maxPrice != null
                        ? "Price ${context.read<StoreCubit>().minPrice != null ? 'Min:${context.read<StoreCubit>().minPrice}' : ''}${context.read<StoreCubit>().maxPrice != null ? ' Max:${context.read<StoreCubit>().maxPrice}' : ''}"
                        : "Price",
                    icon: Icons.attach_money,
                    onTap: () => showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (_) => FilterBottomSheet(
                        title: "Price",
                        options: ["Min", "Max"],
                        initialValue:
                            context.read<StoreCubit>().maxPrice != null
                            ? "Max"
                            : (context.read<StoreCubit>().minPrice != null
                                  ? "Min"
                                  : null),
                        onSelect: (option) {
                          if (option == "Min") {
                            context.read<StoreCubit>().updateFilters(
                              minPrice: 0,
                            );
                          }
                          if (option == "Max") {
                            context.read<StoreCubit>().updateFilters(
                              maxPrice: 1000,
                            );
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  FilterButton(
                    title: context.read<StoreCubit>().gender ?? "Gender",
                    icon: Icons.person,
                    onTap: () => showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (_) => FilterBottomSheet(
                        title: "Gender",
                        options: ["Men", "Women", "Kids"],
                        initialValue: context.read<StoreCubit>().gender,
                        onSelect: (option) {
                          context.read<StoreCubit>().updateFilters(
                            gender: option,
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  FilterButton(
                    title: context.read<StoreCubit>().sort ?? "Sort by",
                    icon: Icons.sort,
                    onTap: () => showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (_) => FilterBottomSheet(
                        title: "Sort",
                        options: ["Newest", "Oldest"],
                        initialValue: context.read<StoreCubit>().sort,
                        onSelect: (option) {
                          context.read<StoreCubit>().updateFilters(
                            sort: option,
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Products / Categories
            Expanded(
              child: BlocBuilder<StoreCubit, StoreState>(
                builder: (context, state) {
                  List products = [];
                  bool showCategories = true;

                  if (state is StoreLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is StoreError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is StoreCategoriesLoaded) showCategories = true;
                  if (state is StoreProductsLoaded) {
                    products = state.products;
                    showCategories = false;
                  }

                  return Column(
                    children: [
                      if (showCategories && state is StoreCategoriesLoaded)
                        ShopByCatWidget(
                          categories: state.categories,
                          onCategorySelected: (catId) {
                            context.read<StoreCubit>().fetchProductsByCategory(
                              catId,
                            );
                          },
                        ),
                      Expanded(
                        child: products.isNotEmpty
                            ? GridView.builder(
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
                                    onTap: (){
                                      print("product: "+product.name);
                                     Navigator.pushNamed(context, AppRoutes.productDetails, arguments: product);
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
                            : const Center(child: Text("No Products Found")),
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
