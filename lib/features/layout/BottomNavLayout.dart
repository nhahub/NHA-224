// ignore_for_file: file_names

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/features/notifications/Screens/notifications_screen.dart';
import 'package:depi_final_project/features/notifications/Screens/orders_screen.dart';
import 'package:depi_final_project/features/store/screens/home.dart';
import 'package:flutter/material.dart';

class BottomNavLayout extends StatefulWidget {
  const BottomNavLayout({super.key});

  @override
  State<BottomNavLayout> createState() => _BottomNavLayoutState();
}

class _BottomNavLayoutState extends State<BottomNavLayout> {
  int currentIndex = 0;

  final List<Widget> _pages = [
    HomeView(),
    // FavoritesPage(),
    // CartPage(),
    NotificationsScreen(),
    OrdersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[currentIndex]),

      /// ---------------- ConvexAppBar ----------------
      // bottomNavigationBar: ConvexAppBar(
      //   style: TabStyle.react,
      //   backgroundColor: AppColors.bg,
      //   activeColor: AppColors.primary,
      //   color: AppColors.greyDark,
      //   elevation: 8,
      //   items: const [
      //     TabItem(
      //       icon: Icons.home_outlined,
      //       activeIcon: Icons.home,
      //       title: "Home",
      //     ),
      //     TabItem(
      //       icon: Icons.favorite_border,
      //       activeIcon: Icons.favorite,
      //       title: "Favorites",
      //     ),
      //     TabItem(
      //       icon: Icons.shopping_cart_outlined,
      //       activeIcon: Icons.shopping_cart,
      //       title: "Cart",
      //     ),
      //   ],
      //   initialActiveIndex: currentIndex,
      //   onTap: (index) => setState(() => currentIndex = index),
      // ),

      // / ---------------- CurvedNavigationBar ----------------
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        height: 60,
        backgroundColor: AppColors.darkTextPrimary,
        color: AppColors.white,
        buttonBackgroundColor: AppColors.white,
        animationDuration: const Duration(milliseconds: 300),
        items: [
          Icon(Icons.home, size: 30, color: AppColors.lightPrimary),
          Icon(Icons.favorite, size: 30, color: AppColors.lightPrimary),
          Icon(Icons.shopping_cart, size: 30, color: AppColors.lightPrimary),
        ],
        onTap: (index) => setState(() => currentIndex = index),
      ),
    );
  }
}
