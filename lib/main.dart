import 'package:depi_final_project/data/repos/home_repo_implementation.dart';
import 'package:depi_final_project/data/sources/firebase_service.dart';
import 'package:depi_final_project/features/personalization/cubit/personalization_cubit.dart';
import 'package:depi_final_project/features/store/cubit/store_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:depi_final_project/firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/features/Auth/cubit/auth_cubit.dart';
import 'package:depi_final_project/core/theme/colors.dart'; // تأكد إن الملف ده موجود

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => PersonalizationCubit()),
        // BlocProvider(
        // create: (context) => SearchCubit(
        // HomeRepoImplementation(firebaseService: FirebaseService()),
        // ),
        // ),
        BlocProvider(
          create: (context) => StoreCubit(
            HomeRepoImplementation(firebaseService: FirebaseService()),
          )..fetchCategories(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'خليها علينا',
            theme: lightMode,
            darkTheme: darkMode,
            initialRoute: AppRoutes.search,
            onGenerateRoute: AppRoutes.generateRoute,
          );
        },
      ),
    );
  }
}
