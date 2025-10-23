import 'package:depi_final_project/features/Auth/cubit/auth_cubit.dart';
import 'package:depi_final_project/features/Auth/cubit/auth_state.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  String? email, password;

  @override
  Widget build(BuildContext context) {
    // final cubit = context.read<AuthCubit>();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        setState(() {
          isLoading = state is AuthLoading;
        });
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.layout,
            arguments: email,
          );
        }
        if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
builder: (parentContext, state){
final cubit = context.read<AuthCubit>();
return ModalProgressHUD(
        inAsyncCall: state is AuthLoading,
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
                    verticalSpacing(35),

                    /// 🔷 Email Field
                    Text("Email", style: AppTextStyles.font17BlackMedium),
                    SizedBox(height: 8.h),
                    CustomFormTextField(
                      hintText: "Enter your email",
                      onChanged: (data) => email = data,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    verticalSpacing(18),

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
                          Navigator.pushNamed(
                            context,
                            AppRoutes.forgetPassword,
                          );
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
                    verticalSpacing(20),

                    /// 🔷 Login Button
                    CustomButton(
                      text: "LOGIN",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await cubit.loginUser(
                          //  context: context,
                            email: email!,
                            password: password!,
                          );
                        }
                      },
                    ),
                    verticalSpacing(25),

                    /// 🔷 Divider
                    OrWidget(),
                    verticalSpacing(25),

                    /// 🔷 Google Sign-in
                    GoogleBottom(
                      onTap: ()async => await cubit.loginWithGoogle()
                    ),

                    verticalSpacing(25),

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
      );}
    );
  }
}
