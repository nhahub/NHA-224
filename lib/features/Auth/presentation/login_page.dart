import 'package:depi_final_project/features/Auth/presentation/widgets/google_widget.dart';
import 'package:depi_final_project/features/Auth/presentation/widgets/or_widgets.dart';
import 'package:depi_final_project/features/Auth/presentation/widgets/title_auth_page.dart';
import 'package:flutter/material.dart';
import 'package:depi_final_project/core/errors/failures.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/features/Auth/presentation/widgets/custom_button.dart';
import 'package:depi_final_project/features/Auth/presentation/widgets/custom_text_field.dart';
import 'package:depi_final_project/features/Auth/services/auth_service.dart';
import 'package:depi_final_project/shared/spacing.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey();
  final AuthService authService = AuthService();

  String? email, password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: AppColors.lightPrimary.withOpacity(0.4),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔷 Title
                  TitleAuthPages(text: 'Login to your account'),

                  SizedBox(height: 6.h),
                  Text(
                    "It’s great to see you again.",
                    style: AppTextStyles.font17BlackRegular.copyWith(
                      color: AppColors.darkSecondary,
                      fontSize: 16.sp,
                    ),
                  ),
                  verticaalSpacing(35),

                  /// 🔷 Email Field
                  Text("Email", style: AppTextStyles.font17BlackMedium),
                  SizedBox(height: 8.h),
                  CustomFormTextField(
                    hintText: "Enter your email",
                    onChanged: (data) => email = data,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  verticaalSpacing(18),

                  /// 🔷 Password Field
                  Text("Password", style: AppTextStyles.font17BlackMedium),
                  SizedBox(height: 8.h),
                  CustomFormTextField(
                    hintText: "Enter your password",
                    obscureText: true,
                    onChanged: (data) => password = data,
                  ),

                  /// 🔷 Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.forgetPassword);
                        // if (email != null && email!.isNotEmpty) {
                        //   authService.resetPassword(
                        //     context: context,
                        //     email: email!,
                        //   );
                        // } else {
                        //   showSnackBar(
                        //     context,
                        //     'Please enter your email first.',
                        //   );
                        // }
                      },
                      child: Text(
                        "Forgot your password?",
                        style: AppTextStyles.font17BlackRegular.copyWith(
                          color: AppColors.lightPrimary,
                          fontSize: 15.sp,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  verticaalSpacing(20),

                  /// 🔷 Login Button
                  CustomButton(
                    text: "LOGIN",
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() => isLoading = true);
                        await authService.loginUser(
                          context: context,
                          email: email!,
                          password: password!,
                        );
                        setState(() => isLoading = false);
                      }
                    },
                  ),
                  verticaalSpacing(25),

                  /// 🔷 Divider
                  OrWidget(),
                  verticaalSpacing(25),

                  /// 🔷 Google Sign-in
                  GoogleBottom(),

                  verticaalSpacing(25),

                  /// 🔷 Register Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: AppTextStyles.font17BlackRegular,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.registerPage,
                        ),
                        child: Text(
                          " Register",
                          style: AppTextStyles.font17BlackMedium.copyWith(
                            color: AppColors.lightTextPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
