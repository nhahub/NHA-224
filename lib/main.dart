import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/routes/app_routes.dart'; // لازم تضيف الاستيراد

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: ' Store ',
          // theme: ThemeData.dark().copyWith(
          //   scaffoldBackgroundColor: AppColors.primary,
          //   appBarTheme: AppBarTheme(
          //     backgroundColor: AppColors.primary,
          //     titleTextStyle: TextStyle(
          //       color: AppColors.white,
          //       fontSize: 24.sp,
          //       fontWeight: FontWeight.bold,
          //     ),
          //     iconTheme: IconThemeData(color: AppColors.white),
          //   ),
          // ),
          onGenerateRoute: AppRoutes.generateRoute,
          initialRoute: AppRoutes.search,
        );
      },
    );
  }
}
