import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/data/models/product_model.dart';
import 'package:depi_final_project/features/store/cubit/cart_cubit.dart';
import 'package:depi_final_project/features/store/cubit/cart_state.dart';
import 'package:depi_final_project/features/store/widgets/counter_btn.dart';
import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/widgets/app_bar_widget.dart';
import 'package:depi_final_project/features/store/widgets/cart_item.dart';
import 'package:depi_final_project/features/store/widgets/coupon_card.dart';
import 'package:depi_final_project/features/store/widgets/price_detail.dart';
import 'package:google_fonts/google_fonts.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CartCubit>().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final cubit = context.read<CartCubit>();

    TextEditingController _countController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart", style: AppTextStyles.font20WitekBold),
        centerTitle: true,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoaded && state.cartWithDetails.isEmpty) {
            return _buildEmptyCart(theme);
          }
          if (state is CartLoading)
            return Center(
              child: CircularProgressIndicator(color: AppColors.darkPrimary),
            );

          if (state is RemoveAllSuccess) return _buildEmptyCart(theme);

          if (state is CartLoaded) {
            final items = state.cartWithDetails;

            double subtotal = 0;
            double shippingCost = 0;
            double tax = 0;
            double total = 0;
            for (var item in items) {
              subtotal += item.product.price;
              shippingCost = subtotal + 20;
              tax = 0.14;
              total = (subtotal * tax) + shippingCost;
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: SingleChildScrollView(
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
                                title: Text("Remove all product"),
                                content: Text(
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
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.darkPrimary,
                                      textStyle: TextStyle(color: Colors.white),
                                    ),
                                    child: Text(
                                      "No",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        },
                        child: Text(
                          "Remove all",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 340.h,
                      child: ListView.builder(
                        itemCount: state.cartWithDetails.length,
                        itemBuilder: (context, i) {
                          final item = items[i];
                          print(item.product.name);
                          print("id: ${item.product.id}");
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: CartItem(
                              onLongTab: () {
                                print("Delete product");
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: Text("Delete product"),
                                      content: Text(
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
                                          child: Text("Yes", style: TextStyle(color: Colors.white),),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.darkPrimary,
                                          ),
                                          child: Text("No",style: TextStyle(color: Colors.white)),
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

                              onEdit: () {
                                _countController.text =
                                    "${item.cartDetails.quantity}";
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return AlertDialog(
                                          title: Text("Edit product quantity"),
                                          content: Row(
                                            children: [
                                              Expanded(
                                                child: CounterBtn(
                                                  icon: "--",
                                                  onTap: () {
                                                    setState(() {
                                                      if (item
                                                              .cartDetails
                                                              .quantity >
                                                          1) {
                                                        item
                                                                .cartDetails
                                                                .quantity -=
                                                            1;
                                                        _countController.text =
                                                            "${item.cartDetails.quantity}";
                                                      }
                                                    });
                                                    print(
                                                      item.cartDetails.quantity,
                                                    );
                                                  },
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: TextField(
                                                  controller: _countController,
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                    hintText: "xxx",
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: CounterBtn(
                                                  icon: "+",
                                                  onTap: () {
                                                    setState(() {
                                                      if (item
                                                              .cartDetails
                                                              .quantity <
                                                          item.product.stock) {
                                                        item
                                                                .cartDetails
                                                                .quantity +=
                                                            1;
                                                        _countController.text =
                                                            "${item.cartDetails.quantity}";
                                                      }
                                                    });
                                                    print(
                                                      item.cartDetails.quantity,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),

                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                cubit.editProductQuantity(
                                                  item.product.id,
                                                  int.parse(
                                                    _countController.text,
                                                  ),
                                                  item.product.stock,
                                                );
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.darkPrimary,
                                              ),
                                              child: Text(
                                                "Save",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(color: Colors.white24, thickness: 1, height: 24.h),
                    _buildPriceSection(
                      theme,
                      subTotal: subtotal,
                      shippingCost: shippingCost,
                      tax: tax,
                      total: total,
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

          return Center(
            child: CircularProgressIndicator(color: AppColors.darkPrimary),
          );
        },
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
            Image.asset("assets/images/bag.png", width: 140.w, height: 140.h),
            SizedBox(height: 24.h),
            Text(
              "Your cart is empty",
              style: GoogleFonts.gabarito(
                fontSize: 22.sp,
                color: AppColors.darkSurface,
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
                backgroundColor: AppColors.darkPrimary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 14.h),
              ),
              child: Text(
                "Explore category",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
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
  }) {
    return Column(
      children: [
        PriceDetail(title: "Subtotal", price: subTotal ?? 0),
        PriceDetail(title: "Shipping cost", price: shippingCost ?? 0),
        PriceDetail(title: "Tax", price: tax ?? 0),
        PriceDetail(title: "Total", price: total ?? 0, isPriceBolded: true),
        SizedBox(height: 12.h),
        CouponCard(),
        SizedBox(height: 20.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.checkout);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkPrimary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              "Checkout",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
