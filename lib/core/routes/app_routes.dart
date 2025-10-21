import 'package:flutter/material.dart';
import 'package:depi_final_project/features/store/screens/home.dart';
import 'package:depi_final_project/features/layout/BottomNavLayout.dart';
import 'package:depi_final_project/features/store/screens/search_page.dart';
import 'package:depi_final_project/features/authentication/screens/email_sent.dart';
import 'package:depi_final_project/features/authentication/screens/signin_email.dart';
import 'package:depi_final_project/features/authentication/screens/splash_screen.dart';
import 'package:depi_final_project/features/authentication/screens/create_account.dart';
import 'package:depi_final_project/features/authentication/screens/forgot_password.dart';
import 'package:depi_final_project/features/authentication/screens/signin_password.dart';

class AppRoutes {
  static const String layout = '/';
  static const String search = '/search';
  static const String productDetails = '/productDetails';
  static const String cart = '/cart';
  static const String splash = '/splash';
  static const String signInEmail = '/signInEmail';
  static const String signInPassword = '/signInPassword';
  static const String signUp = '/signUp';
  static const String forgetPassword = '/forgetPassword';
  static const String sentEmail = '/sentEmail';
  static const String tellUsAboutYou = '/tellUsAboutYou';
  static const String home = '/home';
  static const String emailSent = '/emailSent';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case layout:
        return MaterialPageRoute(builder: (_) => const BottomNavLayout());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case signInEmail:
        return MaterialPageRoute(builder: (_) => SignInEmail());
      case signInPassword:
        return MaterialPageRoute(builder: (_) => SignInPassword());
      case signUp:
        return MaterialPageRoute(builder: (_) => CreateAccount());
      case home:
        return MaterialPageRoute(builder: (_) => const BottomNavLayout());
      case forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case emailSent:
        return MaterialPageRoute(builder: (_) => const EmailSent());
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
