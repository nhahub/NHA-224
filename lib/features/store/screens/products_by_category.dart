import 'package:flutter/material.dart';
import 'package:depi_final_project/shared/spacing.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/features/store/widgets/product_widget.dart';

class ProductsByCategory extends StatelessWidget {
  const ProductsByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> products = [
      {
        'image': 'assets/images/Rectangle 8.png',
        'title': 'Classic Hoodie',
        'price': '\$49.99',
      },
      {
        'image': 'assets/images/Rectangle 8.png',
        'title': 'Zipped Hoodie',
        'price': '\$59.99',
      },
      {
        'image': 'assets/images/Rectangle 8.png',
        'title': 'Oversized Hoodie',
        'price': '\$69.99',
      },
      {
        'image': 'assets/images/Rectangle 8.png',
        'title': 'Basic Hoodie',
        'price': '\$39.99',
      },
      {
        'image': 'assets/images/Rectangle 8.png',
        'title': 'Classic Hoodie',
        'price': '\$49.99',
      },
      {
        'image': 'assets/images/Rectangle 8.png',
        'title': 'Zipped Hoodie',
        'price': '\$59.99',
      },
      {
        'image': 'assets/images/Rectangle 8.png',
        'title': 'Oversized Hoodie',
        'price': '\$69.99',
      },
      {
        'image': 'assets/images/Rectangle 8.png',
        'title': 'Basic Hoodie',
        'price': '\$39.99',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Hoodies',
          style: AppTextStyles.font20WitekBold.copyWith(fontSize: 22.sp),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explore the latest hoodies',
                style: AppTextStyles.font17WiteRegular.copyWith(
                  color: Colors.white70,
                  fontSize: 16.sp,
                ),
              ),
              verticalSpacing(24),

              /// ✅ GridView.builder لإظهار منتجين في كل صف
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // صفين
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 0.7, // للتحكم في ارتفاع كل عنصر
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductWidget(
                    image: product['image']!,
                    title: product['title']!,
                    price: product['price']!,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
