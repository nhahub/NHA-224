import 'widgets/admin_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/features/Auth/cubit/auth_cubit.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Admin Panel',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.h),
            Text(
              'Product Management',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: AdminButton(
                    title: 'Add Product',
                    icon: Icons.add,
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.addProduct),
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: AdminButton(
                    title: 'View Products',
                    icon: Icons.list,
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.viewProducts),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
            Text(
              'Category Management',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: AdminButton(
                    title: 'Add Category',
                    icon: Icons.add,
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.addCategory),
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: AdminButton(
                    title: 'View Categories',
                    icon: Icons.list,
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.viewCategories),
                  ),
                ),
              ],
            ),
            const Spacer(),
            AdminButton(
              title: 'Sign Out',
              icon: Icons.logout,
              color: Colors.red,
              onPressed: () async {
                await context.read<AuthCubit>().logout();
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
