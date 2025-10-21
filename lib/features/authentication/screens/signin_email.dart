import 'package:flutter/material.dart';
import 'package:depi_final_project/shared/spacing.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:depi_final_project/features/authentication/widgets/custom_button.dart';
import 'package:depi_final_project/features/authentication/widgets/social_button.dart';
import 'package:depi_final_project/features/authentication/widgets/custom_text_field.dart';

class SignInEmail extends StatelessWidget {
  const SignInEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticaalSpacing(80),
                Text(
                  'Sign in',
                  style: AppTextStyles.font17BlackMedium.copyWith(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticaalSpacing(18),
                CustomTextField(labelText: 'Email Address'),
                verticaalSpacing(24),
                CustomButton(
                  textButton: 'Continue',
                  onPressed: () => Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.signInPassword,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: AppTextStyles.font17WiteRegular.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.signUp),
                      child: Text(
                        'Create One',
                        style: AppTextStyles.font17WiteRegular.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                verticaalSpacing(40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SocialButton(
                      textButton: 'Continue with Apple',
                      icon: FontAwesomeIcons.apple,
                    ),
                    SocialButton(
                      textButton: 'Continue with Google',
                      icon: FontAwesomeIcons.google,
                    ),
                    SocialButton(
                      textButton: 'Continue with Facebook',
                      icon: FontAwesomeIcons.facebook,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
