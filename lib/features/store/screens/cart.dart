import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/widgets/app_bar_widget.dart';
import 'package:depi_final_project/features/store/widgets/cart_item.dart';
import 'package:depi_final_project/features/store/widgets/coupon_card.dart';
import 'package:depi_final_project/features/store/widgets/price_detail.dart';

class Cart extends StatelessWidget {
  Cart({super.key});

  final List<CartItem> cartItems = [
    CartItem(
      title: "Men's Harrington Jacket",
      price: 148,
      size: "- M",
      color: "- Lemon",
      image: 'assets/images/image1.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const CustomAppBar(title: "Cart"),
      body: cartItems.isEmpty
          ? _buildEmptyCart(theme)
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
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
                        itemCount: cartItems.length,
                        itemBuilder: (context, i) => Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: cartItems[i],
                        ),
                      ),
                    ),
                    Divider(color: Colors.white24, thickness: 1, height: 24.h),
                    _buildPriceSection(theme),
                  ],
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
            Image.asset("assets/images/bag.png", width: 140.w, height: 140.h),
            SizedBox(height: 24.h),
            Text(
              "Your cart is empty",
              style: TextStyle(
                fontSize: 22.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              "Looks like you haven't added anything yet.",
              style: TextStyle(fontSize: 14.sp, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 28.h),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkSecondary,
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
  Widget _buildPriceSection(ColorScheme theme) {
    return Column(
      children: [
        PriceDetail(title: "Subtotal", price: 200),
        PriceDetail(title: "Shipping cost", price: 8),
        PriceDetail(title: "Tax", price: 0),
        PriceDetail(title: "Total", price: 208, isPriceBolded: true),
        SizedBox(height: 12.h),
        CouponCard(),
        SizedBox(height: 20.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkSecondary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 16.h),
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
