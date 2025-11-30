import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/widgets/app_bar_widget.dart';
import 'package:depi_final_project/features/personalization/ui/widget/favorite_widget.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: const CustomAppBar(title: "My Favourites"),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .collection("favourite")
            .snapshots(),

        builder: (context, snapshot) {
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return _buildEmptyState();
          }

          final favItems = snapshot.data!.docs;

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
              itemCount: favItems.length,
              itemBuilder: (context, index) {
                final fav = favItems[index];
                final id = fav.id;

                return FavouriteWidget(
                  image: fav["image"],
                  title: fav["title"],
                  price: fav["price"],
                  isFavorite: true,

                  onFavoriteTap: () async {
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(userId)
                        .collection("favorites")
                        .doc(id)
                        .delete();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Removed from favorites")),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.grey[400]),
          SizedBox(height: Spacing.md),
          Text(
            "No favorites yet",
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey[600]),
          ),
          SizedBox(height: Spacing.sm),
          Text(
            "Start adding items to your favorites",
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
