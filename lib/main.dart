import 'package:depi_final_project/features/store/screens/product_page.dart';
import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
            title: 'خليها علينا',
             theme: lightMode,
             darkTheme: darkMode,

            /*ThemeData.dark().copyWith(
              scaffoldBackgroundColor: AppColors.primary,
              appBarTheme: AppBarTheme(
                backgroundColor: AppColors.primary,
                titleTextStyle: TextStyle(
                  color: AppColors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(color: AppColors.white),
              ),*/

              
            // ),
            home: child,
        );
      },
      child: ProductPage(),
    );
  }
}
