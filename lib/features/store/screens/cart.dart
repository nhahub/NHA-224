import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/data/models/product_model.dart';
import 'package:depi_final_project/core/widgets/cart_skeleton.dart';
import 'package:depi_final_project/core/widgets/app_bar_widget.dart';
import 'package:depi_final_project/features/store/cubit/cart_cubit.dart';
import 'package:depi_final_project/features/store/cubit/cart_state.dart';
import 'package:depi_final_project/features/store/widgets/cart_item.dart';
import 'package:depi_final_project/core/widgets/progress_hud_widget.dart';
import 'package:depi_final_project/features/store/widgets/counter_btn.dart';
import 'package:depi_final_project/features/store/widgets/coupon_card.dart';
import 'package:depi_final_project/features/store/widgets/price_detail.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool _isInitialLoad = true;

  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final cubit = context.read<CartCubit>();

    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartLoaded) {
          _isInitialLoad = false;
        }
        if (state is CartError) {
          _isInitialLoad = false;
        }
      },
      child: ProgressHUDWidget(
        isLoading:
            !_isInitialLoad && context.watch<CartCubit>().state is CartLoading,
        child: Scaffold(
          appBar: const CustomAppBar(title: "Cart"),
          body: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartLoaded && state.cartWithDetails.isEmpty) {
                return _buildEmptyCart(theme);
              }

              if (state is RemoveAllSuccess) return _buildEmptyCart(theme);

              if (state is CartLoaded) {
                final items = state.cartWithDetails;

                // 1. حساب السعر الإجمالي
                double subtotal = items.fold(
                  0.0,
                  (sum, item) =>
                      sum + item.product.price * item.cartDetails.quantity,
                );

                // 2. (تعديل جديد) حساب عدد العناصر الكلي
                int totalItemsCount = items.fold(
                  0,
                  (sum, item) => sum + item.cartDetails.quantity,
                );

                double shippingCost = 20.0;
                double tax = subtotal * 0.14;
                double total = subtotal + shippingCost + tax;

                return SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: const Text("Remove all product"),
                                    content: const Text(
                                      "Are you sure you want to delete all your cart items",
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          cubit.removeAllCartProducts();
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        child: const Text(
                                          "Yes",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: theme.primary,
                                          foregroundColor: theme.onPrimary,
                                        ),
                                        child: const Text("No"),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            },
                            child: Text(
                              "Remove all",
                              style: TextStyle(
                                color: theme.onSurface,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.cartWithDetails.length,
                          itemBuilder: (context, i) {
                            final item = items[i];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: CartItem(
                                onLongTab: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        title: const Text("Delete product"),
                                        content: const Text(
                                          "Are you sure you want to delete this product",
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              cubit.deleteProduct(
                                                item.product.id,
                                              );
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                            ),
                                            child: const Text(
                                              "Yes",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: theme.primary,
                                              foregroundColor: theme.onPrimary,
                                            ),
                                            child: const Text("No"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                image: item.product.imageUrl[0],
                                price: item.product.price,
                                size: item.cartDetails.selectedSize,
                                color: item.cartDetails.selectedColor,
                                title: item.product.name,
                                quantity: item.cartDetails.quantity,
                                onIncrement: () {
                                  if (item.cartDetails.quantity <
                                      item.product.stock) {
                                    cubit.editProductQuantity(
                                      item.product.id,
                                      item.cartDetails.quantity + 1,
                                      item.product.stock,
                                    );
                                  }
                                },
                                onDecrement: () {
                                  if (item.cartDetails.quantity > 1) {
                                    cubit.editProductQuantity(
                                      item.product.id,
                                      item.cartDetails.quantity - 1,
                                      item.product.stock,
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        ),
                        Divider(
                          color: Colors.white24,
                          thickness: 1,
                          height: 24.h,
                        ),
                        // 3. تمرير العدد الكلي لدالة السعر
                        _buildPriceSection(
                          theme,
                          subTotal: subtotal,
                          shippingCost: shippingCost,
                          tax: tax,
                          total: total,
                          itemCount: totalItemsCount, // القيمة الجديدة
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (state is CartError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }

              // Loading state - show skeleton
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 20,
                          width: 80,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      const CartItemSkeleton(),
                      Divider(
                        color: Colors.white24,
                        thickness: 1,
                        height: 24.h,
                      ),
                      // Price section skeleton
                      Container(
                        height: 16,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                        margin: const EdgeInsets.only(bottom: 12),
                      ),
                      Container(
                        height: 16,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                        margin: const EdgeInsets.only(bottom: 12),
                      ),
                      Container(
                        height: 16,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                        margin: const EdgeInsets.only(bottom: 12),
                      ),
                      Container(
                        height: 18,
                        width: double.infinity,
                        color: AppColors.figmaPrimary.withOpacity(0.5),
                        margin: const EdgeInsets.only(bottom: 20),
                      ),
                      // Coupon skeleton
                      Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                        margin: const EdgeInsets.only(bottom: 20),
                      ),
                      // Checkout button skeleton
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.figmaPrimary.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// 🛒 في حالة السلة فاضية
  Widget _buildEmptyCart(ColorScheme theme) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: 0.6,
              child: Image.asset(
                "assets/images/bag.png",
                width: 140.w,
                height: 140.h,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              "Your cart is empty",
              style: TextStyle(
                fontSize: 22.sp,
                color: theme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(height: 28.h),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.search);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primary,
                foregroundColor: theme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.r),
                ),
              ),
              child: Text(
                "Shop now",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 💰 الجزء الخاص بالسعر والإجمالي
  Widget _buildPriceSection(
    ColorScheme theme, {
    double? subTotal,
    double? shippingCost,
    double? tax,
    double? total,
    required int itemCount, // 4. استقبال العدد هنا
  }) {
    return Column(
      children: [
        PriceDetail(title: "Subtotal", price: subTotal ?? 0),
        PriceDetail(title: "Shipping cost", price: shippingCost ?? 0),
        PriceDetail(title: "Tax", price: tax ?? 0),
        PriceDetail(title: "Total", price: total ?? 0, isPriceBolded: true),
        SizedBox(height: 12.h),
        const CouponCard(),
        SizedBox(height: 20.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            // 5. تعديل الزر لإرسال البيانات
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.checkout,
                arguments: {
                  'totalPrice': total ?? 0.0,
                  'totalItems': itemCount,
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primary,
              foregroundColor: theme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              "Checkout",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
