import 'package:flutter/material.dart';
import 'package:depi_final_project/shared/spacing.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/features/authentication/widgets/custom_button.dart';
import 'package:depi_final_project/features/authentication/widgets/custom_text_field.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({super.key});

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
                verticaalSpacing(20),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.darkSecondary,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(10),
                      backgroundColor: AppColors.darkSecondary,
                    ),
                    child: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                verticaalSpacing(20),
                Text(
                  'Create Account',
                  style: AppTextStyles.font17BlackMedium.copyWith(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticaalSpacing(24),
                CustomTextField(labelText: 'First Name'),
                verticaalSpacing(18),
                CustomTextField(labelText: 'Last Name'),
                verticaalSpacing(18),
                CustomTextField(labelText: 'Email Address'),
                verticaalSpacing(18),
                CustomTextField(labelText: 'Password'),
                verticaalSpacing(24),
                CustomButton(
                  textButton: 'Continue',
                  onPressed: () => Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.tellUsAboutYou,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Forgot Password? ",
                      style: AppTextStyles.font17WiteRegular.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.forgetPassword,
                      ),
                      child: Text(
                        'Reset',
                        style: AppTextStyles.font17WiteRegular.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
