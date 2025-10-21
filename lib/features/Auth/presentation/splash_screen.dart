import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

@override
Widget build(BuildContext context) {
// ignore: use_build_context_synchronously
Future.delayed(Duration(milliseconds: 900), () => Navigator.pushReplacementNamed(context, AppRoutes.login));


return Scaffold(
backgroundColor: AppColors.lightPrimary,
body: SafeArea(
child: Center(
child: Text('Vevo', style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold)),
),
),
);
}}