import 'package:flutter/material.dart';
import 'package:depi_final_project/shared/spacing.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/features/store/widgets/category_container.dart';

class ShopByCategory extends StatelessWidget {
  const ShopByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shop by Categories',
                style: AppTextStyles.font20WitekBold.copyWith(fontSize: 24.sp),
              ),
              verticalSpacing(24),
              CategoryContainer(),
              CategoryContainer(),
              CategoryContainer(),
              CategoryContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
