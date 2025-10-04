import 'package:depi_final_project/features/layout/BottomNavLayout.dart';
import 'package:depi_final_project/features/store/screens/search_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String layout = '/';
  static const String search = '/search';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case layout:
        return MaterialPageRoute(builder: (_) => const BottomNavLayout());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchPage());
      default:
        return _errorRoute("Route not found: ${settings.name}");
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Route Error')),
        body: Center(child: Text(message)),
      ),
    );
  }
}
