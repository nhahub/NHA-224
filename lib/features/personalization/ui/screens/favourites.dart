import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/widgets/app_bar_widget.dart';
import 'package:depi_final_project/features/personalization/ui/widget/favorite_widget.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  // Mock data for favorites - in a real app, this would come from a state management solution
  List<Map<String, String>> favoriteItems = [
    {'image': 'assets/images/image1.png', 'title': 'Nike Fuel Pack', 'price': '\$23.00'},
    {'image': 'assets/images/image2.png', 'title': 'Nike Air Max', 'price': '\$45.00'},
    {'image': 'assets/images/avatar2.png', 'title': 'Nike React', 'price': '\$35.00'},
  ];

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "My Favourites",
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : favoriteItems.isEmpty
              ? _buildEmptyState()
              : _buildFavoritesGrid(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: Colors.grey[400],
          ),
          SizedBox(height: Spacing.md),
          Text(
            "No favorites yet",
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: Spacing.sm),
          Text(
            "Start adding items to your favorites",
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesGrid() {
    return Padding(
      padding: EdgeInsets.all(Spacing.lg),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: Spacing.md,
          mainAxisSpacing: Spacing.md,
          childAspectRatio: 0.68,
        ),
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          final item = favoriteItems[index];
          return FavoriteWidget(
            image: item['image']!,
            title: item['title']!,
            price: item['price']!,
            isFavorite: true,
            onFavoriteTap: () {
              setState(() {
                favoriteItems.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Removed from favorites'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
