import 'package:depi_final_project/features/Auth/presentation/login_page.dart';
import 'package:depi_final_project/features/Auth/presentation/resgister_page.dart';
import 'package:depi_final_project/features/Auth/presentation/splash_screen.dart';
import 'package:depi_final_project/features/admin/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:depi_final_project/features/layout/BottomNavLayout.dart';
import 'package:depi_final_project/features/store/screens/search_page.dart';

class AppRoutes {
  static const String layout = '/';
  static const String search = '/search';
  static const String productDetails = '/productDetails';
  static const String cart = '/cart';
  static const String splash = '/splash';
  static const String forgetPassword = '/forgetPassword';
  static const String tellUsAboutYou = '/tellUsAboutYou';
  static const String home = '/home';
  static const String login = '/login';
  static const String adminPage = '/adminPage';
  static const String registerPage = '/registerPage';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case layout:
        return MaterialPageRoute(builder: (_) => const BottomNavLayout());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
        case registerPage:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case adminPage:
        return MaterialPageRoute(builder: (_) => const AdminPage());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const BottomNavLayout());
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
