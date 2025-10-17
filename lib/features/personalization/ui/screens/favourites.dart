import 'package:depi_final_project/features/personalization/ui/widget/favouriteWidget.dart';
import 'package:flutter/material.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Favourites",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Row(
              children: [
                FavouriteWidget(
                  imageUrl: 'images/image1.png',
                  name: 'Nike Fuel Pack',
                  price: 23.00,
                ),
                FavouriteWidget(
                  imageUrl: 'images/image2.png',
                  name: 'Nike Fuel Pack',
                  price: 23.00,
                ),
              ],
            ),
            Row(
              children: [
                FavouriteWidget(
                  imageUrl: 'images/avatar2.png',
                  name: 'Nike Fuel Pack',
                  price: 23.00,
                ),
                FavouriteWidget(
                  imageUrl: 'images/avatar2.png',
                  name: 'Nike Fuel Pack',
                  price: 23.00,
                ),
              ],
            ),Row(
              children: [
                FavouriteWidget(
                  imageUrl: 'images/avatar2.png',
                  name: 'Nike Fuel Pack',
                  price: 23.00,
                ),
                FavouriteWidget(
                  imageUrl: 'images/avatar2.png',
                  name: 'Nike Fuel Pack',
                  price: 23.00,
                ),
              ],
            ),Row(
              children: [
                FavouriteWidget(
                  imageUrl: 'images/avatar2.png',
                  name: 'Nike Fuel Pack',
                  price: 23.00,
                ),
                FavouriteWidget(
                  imageUrl: 'images/avatar2.png',
                  name: 'Nike Fuel Pack',
                  price: 23.00,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
