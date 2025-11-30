import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depi_final_project/core/widgets/app_bar_widget.dart';
import 'package:depi_final_project/features/personalization/ui/widget/favoriteWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: ("Favorites"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('favorites')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final favDocs = snapshot.data?.docs ?? [];

          if (favDocs.isEmpty) {
            return Center(
              child: Text("No favorites yet"),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.62,
            ),
            itemCount: favDocs.length,
            itemBuilder: (context, index) {
              final data = favDocs[index].data() as Map<String, dynamic>;
              final docId = favDocs[index].id;

              // أول صورة من imageUrl (list)
              final imageUrl = (data["imageUrl"] as List).isNotEmpty
                  ? data["imageUrl"][0]
                  : "";

              return FavouriteWidget(
                image: imageUrl,
                title: data["name"] ?? "",
                price: "${data["price"]}",
                oldPrice: data["oldPrice"]?.toString(),
                isFavorite: true,
                onFavoriteTap: () {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(userId)
                      .collection("favorites")
                      .doc(docId)
                      .delete();
                },
              );
            },
          );
        },
      ),
    );
  }
}
