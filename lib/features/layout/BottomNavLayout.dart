import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/features/home/home_view.dart';
import 'package:depi_final_project/features/store/screens/cart.dart';
import 'package:depi_final_project/features/layout/CustomBottomBar.dart';
import 'package:depi_final_project/features/notifications/Screens/orders_screen.dart';
import 'package:depi_final_project/features/notifications/Screens/notifications_screen.dart';
class BottomNavLayout extends StatefulWidget {
  const BottomNavLayout({super.key});

  @override
  State<BottomNavLayout> createState() => _BottomNavLayoutState();
}

class _BottomNavLayoutState extends State<BottomNavLayout> {
  final ScrollController _scrollController = ScrollController();
  final double _initialAppBarHeight = 100.h;
  final double _minAppBarHeight = 80.h;
  double _appBarHeight = 100.h;

  int _selectedIndex = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomeView(),
      const OrdersScreen(),
      const NotificationsScreen(),
      Cart(),
      //Center(child: Text(S().ContactUs)),
    ]);
    _scrollController.addListener(_updateAppBarHeight);
  }

  void _updateAppBarHeight() {
    final double currentOffset = _scrollController.offset;

    setState(() {
      _appBarHeight = (_initialAppBarHeight - currentOffset * 0.5).clamp(
        _minAppBarHeight,
        _initialAppBarHeight,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateAppBarHeight);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}