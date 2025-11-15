import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/core/services/shared_preferences_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;

      final prefsService = SharedPreferencesService();
      final String nextRoute;

      // Check if user is already logged in
      if (prefsService.isLoggedIn) {
        // Route based on user role
        if (prefsService.isAdmin) {
          nextRoute = AppRoutes.adminDashboard;
        } else {
          nextRoute = AppRoutes.layout;
        }
      } else {
        nextRoute = AppRoutes.login;
      }

      Navigator.pushReplacementNamed(context, nextRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: SafeArea(
        child: Center(
          child: Text(
            'Vevo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
