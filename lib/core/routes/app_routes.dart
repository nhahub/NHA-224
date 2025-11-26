import 'package:depi_final_project/data/models/product_model.dart';
import 'package:depi_final_project/features/store/screens/cart.dart';
import 'package:depi_final_project/features/store/screens/checkout_screen.dart';
import 'package:depi_final_project/features/store/screens/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depi_final_project/features/admin/admin_page.dart';
import 'package:depi_final_project/features/admin/admin_dashboard.dart';
import 'package:depi_final_project/features/Auth/cubit/auth_cubit.dart';
import 'package:depi_final_project/features/admin/add_product_page.dart';
import 'package:depi_final_project/features/layout/BottomNavLayout.dart';
import 'package:depi_final_project/features/admin/add_category_page.dart';
import 'package:depi_final_project/features/admin/view_products_page.dart';
import 'package:depi_final_project/features/store/screens/search_page.dart';
import 'package:depi_final_project/features/admin/view_categories_page.dart';
import 'package:depi_final_project/features/Auth/presentation/login_page.dart';
import 'package:depi_final_project/features/home/screens/shop_by_category.dart';
import 'package:depi_final_project/features/Auth/presentation/splash_screen.dart';
import 'package:depi_final_project/features/Auth/presentation/resgister_page.dart';
import 'package:depi_final_project/features/home/screens/products_by_category.dart';

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
  static const String adminDashboard = '/admin/dashboard';
  static const String addCategory = '/admin/addCategory';
  static const String addProduct = '/admin/addProduct';
  static const String viewProducts = '/admin/viewProducts';
  static const String viewCategories = '/admin/viewCategories';
  static const String registerPage = '/registerPage';
  static const String shopByCategory = '/shopByCategory';
  static const String productsByCategory = '/productsByCategory';
  static const String allTopSelling = '/allTopSelling';
  static const String allNewIn = '/allNewIn';
  static const String profile = '/profile';
  static const String checkout = '/checkout';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case layout:
        return MaterialPageRoute(builder: (_) => const BottomNavLayout());
      case login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const LoginPage(),
          ),
        );
      case registerPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const RegisterPage(),
          ),
        );
      case adminPage:
        return MaterialPageRoute(builder: (_) => const AdminPage());
      case adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminDashboard());
      case addCategory:
        return MaterialPageRoute(builder: (_) => const AddCategoryPage());
      case addProduct:
        return MaterialPageRoute(builder: (_) => const AddProductPage());
      case viewProducts:
        return MaterialPageRoute(builder: (_) => const ViewProductsPage());
      case viewCategories:
        return MaterialPageRoute(builder: (_) => const ViewCategoriesPage());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const BottomNavLayout());
      case shopByCategory:
        return MaterialPageRoute(builder: (_) => const ShopByCategory());
      case productsByCategory:
        return MaterialPageRoute(builder: (_) => const ProductsByCategory());
      case allTopSelling:
        return MaterialPageRoute(
          builder: (_) => const ProductsByCategory(),
          settings: const RouteSettings(
            arguments: {'categoryName': 'Top Selling', 'categoryId': ''},
          ),
        );
      case allNewIn:
        return MaterialPageRoute(
          builder: (_) => const ProductsByCategory(),
          settings: const RouteSettings(
            arguments: {'categoryName': 'New In', 'categoryId': ''},
          ),
        );
      case profile:
        return MaterialPageRoute(builder: (_) => const BottomNavLayout());
      case productDetails:
        return MaterialPageRoute(
          builder: (_) =>
              ProductPage(product: settings.arguments as ProductModel),
        );
      case cart:
        return MaterialPageRoute(builder: (_) => Cart());
      case checkout:
        return MaterialPageRoute(
          builder: (_) => CheckoutScreen(),
          settings: settings,
        );
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
