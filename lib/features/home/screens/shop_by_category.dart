import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/data/models/category_model.dart';
import 'package:depi_final_project/core/widgets/app_bar_widget.dart';
import 'package:depi_final_project/features/store/cubit/store_cubit.dart';
import 'package:depi_final_project/features/store/cubit/store_state.dart';
import 'package:depi_final_project/features/home/widgets/category_container.dart';

class ShopByCategory extends StatelessWidget {
  const ShopByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Shop by Categories'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shop by Categories',
                style: AppTextStyles.font20WitekBold.copyWith(
                  fontSize: 24.sp,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              verticalSpacing(24),
              // Load categories dynamically from StoreCubit
              BlocBuilder<StoreCubit, StoreState>(
                builder: (context, state) {
                  if (state is StoreCategoriesLoaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    // Fallback: show empty state or default categories
                    return const Center(child: Text('No categories available'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

