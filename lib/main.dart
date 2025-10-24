import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:depi_final_project/firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/features/Auth/cubit/auth_cubit.dart';
import 'package:depi_final_project/features/personalization/ui/screens/profile.dart';
import 'package:depi_final_project/core/theme/colors.dart'; // تأكد إن الملف ده موجود


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    return
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AuthCubit()),
      ],
      child: 
  ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'خليها علينا',
          theme: lightMode,
          darkTheme: darkMode,
          initialRoute: AppRoutes.home,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    ));

  }
}
