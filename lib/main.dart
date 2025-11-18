import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:depi_final_project/firebase_options.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/theme/app_theme.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/core/theme/bloc/theme_bloc.dart';
import 'package:depi_final_project/data/sources/firebase_service.dart';
import 'package:depi_final_project/features/Auth/cubit/auth_cubit.dart';
import 'package:depi_final_project/features/home/cubit/home_cubit.dart';
import 'package:depi_final_project/features/store/cubit/store_cubit.dart';
import 'package:depi_final_project/data/repos/home_repo_implementation.dart';
import 'package:depi_final_project/core/services/shared_preferences_service.dart';
import 'package:depi_final_project/features/personalization/cubit/personalization_cubit.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferencesService().init();
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
        BlocProvider(
          create: (context) => ThemeBloc()..add(GetCuurrentThemeEvent()),
        ),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => PersonalizationCubit()),
        BlocProvider(
          create: (context) => HomeCubit(
            homeRepo: HomeRepoImplementation(firebaseService: FirebaseService()),
          ),
        ),
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
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              // Determine the current theme and theme mode
              AppTheme currentTheme = AppTheme.light;
              ThemeMode themeMode = ThemeMode.light; // Default to light to avoid system theme

              if (themeState is LoadingThemeState) {
                currentTheme = themeState.appTheme;
                themeMode = currentTheme == AppTheme.light ? ThemeMode.light : ThemeMode.dark;
              }

              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: appThemeData[AppTheme.light]!,
                darkTheme: appThemeData[AppTheme.dark]!,
                themeMode: themeMode,
                initialRoute: AppRoutes.splash,
                onGenerateRoute: AppRoutes.generateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
