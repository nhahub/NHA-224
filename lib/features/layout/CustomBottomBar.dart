import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      SalomonBottomBarItem(
        icon: HugeIcon(
          icon: HugeIcons.strokeRoundedHome03,
          color: AppColors.darkPrimary,
          size: 20,
        ),
        title: Text('Home'),
        selectedColor: AppColors.darkPrimary,
      ),
      SalomonBottomBarItem(
        icon: HugeIcon(
          icon: HugeIcons.strokeRoundedReceiptDollar,
          color: AppColors.darkPrimary,
          size: 20,
        ),
        title: Text('Orders'),
        selectedColor: AppColors.darkPrimary,
      ),
      SalomonBottomBarItem(
        icon: HugeIcon(
          icon: HugeIcons.strokeRoundedHotelBell,
          color: AppColors.darkPrimary,
          size: 20,
        ),
        title: Text('Notifications'),
        selectedColor: AppColors.darkPrimary,
      ),

      SalomonBottomBarItem(
        icon: HugeIcon(
          icon: HugeIcons.strokeRoundedUser,
          color: AppColors.darkPrimary,
          size: 20,
        ),
        title: Text('Settings'),
        selectedColor: AppColors.darkPrimary,
      ),
    ];

    return SalomonBottomBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: items,
    );
  }
}
