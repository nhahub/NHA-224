import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
              SizedBox(height: 6),
              Text(
                'Sign in',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 18),
              CustomTextField(labelText: 'Email Address'),
              SizedBox(height: 12),
              // TextField(
              //   controller: _passwordController,
              //   obscureText: true,
              //   decoration: InputDecoration(
              //     labelText: 'Password',
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              // ),
              SizedBox(height: 12),
              CustomButton(
                textButton: 'Continue',
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/home'),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, AppRoutes.signUp),
                    child: Text(
                      'Create One',
                      style: TextStyle(color: AppColors.lightPrimary),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),
              Center(child: Text('or continue with')),
              SizedBox(height: 12),
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
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
