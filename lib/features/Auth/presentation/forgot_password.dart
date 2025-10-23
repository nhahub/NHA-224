import 'package:depi_final_project/features/Auth/presentation/widgets/custom_alert_dialog.dart';
import 'package:depi_final_project/features/Auth/presentation/widgets/title_auth_page.dart';
import 'package:flutter/material.dart';
import 'package:depi_final_project/core/errors/failures.dart';
import 'package:depi_final_project/features/Auth/services/auth_service.dart';
import 'package:depi_final_project/shared/spacing.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/features/Auth/presentation/widgets/custom_button.dart';
import 'package:depi_final_project/features/Auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final AuthService authService = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: AppColors.lightPrimary.withOpacity(0.4),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpacing(30),

                  /// 🔷 Title
                  TitleAuthPages(text: 'Forget Password'),

                  verticalSpacing(30),

                  /// 🔷 Email Input
                  // Text('Email', style: AppTextStyles.font17BlackMedium),
                  SizedBox(height: 8.h),
                  CustomFormTextField(
                    hintText: 'Enter Email Address',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => email = value,
                  ),
                  verticalSpacing(25),

                  /// 🔷 Continue Button
                  CustomButton(
                    text: 'Continue',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        if (email != null && email!.isNotEmpty) {
                          setState(() => isLoading = true);

                          try {
                            await authService.resetPassword(
                              context: context,
                              email: email!,
                            );
                            setState(() => isLoading = false);
                            // Show success dialog
                            showDialog(
                              context: context,
                              builder: (context) => CustomAlertDialog(),
                            );
                          } catch (e) {
                            setState(() => isLoading = false);
                            showSnackBar(context, 'Error: $e');
                          }
                        } else {
                          showSnackBar(
                            context,
                            'Please enter your email first.',
                          );
                        }
                      }
                    },
                  ),

                  verticalSpacing(20),

                  /// 🔷 Back to Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Remember your password?",
                        style: AppTextStyles.font17BlackRegular,
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.login),
                        child: Text(
                          " Login",
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
