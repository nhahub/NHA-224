import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/data/models/category_model.dart';
import 'package:depi_final_project/data/sources/firebase_service.dart';
import 'package:depi_final_project/core/widgets/app_bar_widget.dart';

class ViewCategoriesPage extends StatefulWidget {
  const ViewCategoriesPage({super.key});

  @override
  State<ViewCategoriesPage> createState() => _ViewCategoriesPageState();
}

class _ViewCategoriesPageState extends State<ViewCategoriesPage> {
  late FirebaseService firebaseService;
  final TextEditingController searchController = TextEditingController();
  List<CategoryModel> allCategories = [];
  List<CategoryModel> filteredCategories = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    firebaseService = FirebaseService();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });
      final categories = await firebaseService.getCategories();
      setState(() {
        allCategories = categories;
        filteredCategories = categories;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load categories: $e';
        isLoading = false;
      });
    }
  }

  void filterCategories(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredCategories = allCategories;
      });
    } else {
      setState(() {
        filteredCategories = allCategories
            .where(
              (category) =>
                  category.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      });
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .delete();
      await loadCategories();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Category deleted successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete category: $e')),
        );
      }
    }
  }

  void showDeleteConfirmation(String categoryId, String categoryName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Category'),
        content: Text('Are you sure you want to delete "$categoryName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              deleteCategory(categoryId);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'View Categories',
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              controller: searchController,
              onChanged: filterCategories,
              decoration: InputDecoration(
                hintText: 'Search categories...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage))
                : filteredCategories.isEmpty
                ? Center(
                    child: Text(
                      'No categories found',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16.w),
                    itemCount: filteredCategories.length,
                    itemBuilder: (context, index) {
                      final category = filteredCategories[index];
                      return CategoryCard(
                        category: category,
                        onDelete: () =>
                            showDeleteConfirmation(category.id, category.name),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: loadCategories,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onDelete;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 12.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                width: 80.w,
                height: 80.w,
                color: Colors.grey[300],
                child: category.imageUrl.isNotEmpty
                    ? Image.network(
                        category.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                      )
                    : const Icon(Icons.image, size: 40),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'ID: ${category.id}',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete, color: Colors.red),
              tooltip: 'Delete',
            ),
          ],
        ),
      ),
    );
  }
}
