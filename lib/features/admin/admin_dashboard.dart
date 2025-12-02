import 'widgets/admin_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/core/widgets/app_bar_widget.dart';
import 'package:depi_final_project/features/Auth/cubit/auth_cubit.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Admin Dashboard',
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
            SizedBox(height: 40.h),
            Text(
              'System Settings',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 20.h),
            AdminButton(
              title: 'Cloudinary Settings',
              icon: Icons.cloud_upload,
              onPressed: () => _showCloudinarySettingsDialog(context),
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

  void _showCloudinarySettingsDialog(BuildContext context) {
    final cloudNameController = TextEditingController();
    final uploadPresetController = TextEditingController();
    final folderController = TextEditingController();

    // Load existing settings
    SharedPreferences.getInstance().then((prefs) {
      cloudNameController.text = prefs.getString('cloudinary_cloud_name') ?? 'dp9lb4oie';
      uploadPresetController.text = prefs.getString('cloudinary_upload_preset') ?? 'profile_preset';
      folderController.text = prefs.getString('cloudinary_folder') ?? 'profile_images';
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cloudinary Settings'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: cloudNameController,
                decoration: const InputDecoration(
                  labelText: 'Cloud Name',
                  hintText: 'Your Cloudinary cloud name',
                ),
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: uploadPresetController,
                decoration: const InputDecoration(
                  labelText: 'Upload Preset',
                  hintText: 'Your upload preset name',
                ),
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: folderController,
                decoration: const InputDecoration(
                  labelText: 'Folder (Optional)',
                  hintText: 'Folder to store images',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('cloudinary_cloud_name', cloudNameController.text.trim());
              await prefs.setString('cloudinary_upload_preset', uploadPresetController.text.trim());
              await prefs.setString('cloudinary_folder', folderController.text.trim());

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Cloudinary settings saved successfully!',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
