import 'package:depi_final_project/features/Auth/cubit/auth_cubit.dart';
import 'package:depi_final_project/features/Auth/cubit/auth_state.dart';
import 'package:depi_final_project/features/Auth/presentation/widgets/google_widget.dart';
import 'package:depi_final_project/features/Auth/presentation/widgets/or_widgets.dart';
import 'package:depi_final_project/features/Auth/presentation/widgets/title_auth_page.dart';
import 'package:flutter/material.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/features/Auth/presentation/widgets/custom_button.dart';
import 'package:depi_final_project/features/Auth/presentation/widgets/custom_text_field.dart';
import 'package:depi_final_project/features/Auth/services/auth_service.dart';
import 'package:depi_final_project/shared/spacing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;
  String? password;
  String? name;
  String? profileImageUrl;
  bool isLoading = false;

  final GlobalKey<FormState> formKey = GlobalKey();
  // final AuthService authService = AuthService();
  // final AuthCubit authCubit = AuthCubit();

  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is AuthSuccess){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Verification email sent to your email please check your inbox",)));
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }
        if(state is AuthFailure){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state)  {

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
                    TitleAuthPages(text: 'Create a new account'),
      
                    SizedBox(height: 6.h),
                    Text(
                      "Join us and start your journey!",
                      style: AppTextStyles.font17BlackRegular.copyWith(
                        color: AppColors.darkTextSecondary,
                        fontSize: 16.sp,
                        // fontFamily: 'cairo',
                      ),
                    ),
                    verticalSpacing(35),
      
                    /// 🔷 Name
                    Text("Full Name", style: AppTextStyles.font17BlackMedium),
                    SizedBox(height: 8.h),
                    CustomFormTextField(
                      hintText: "Enter your name",
                      onChanged: (data) => name = data,
                    ),
                    verticalSpacing(18),
      
                    /// 🔷 Email
                    Text("Email", style: AppTextStyles.font17BlackMedium),
                    SizedBox(height: 8.h),
                    CustomFormTextField(
                      hintText: "Enter your email",
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (data) => email = data,
                    ),
                    verticalSpacing(18),
      
                    /// 🔷 Password
                    Text("Password", style: AppTextStyles.font17BlackMedium),
                    SizedBox(height: 8.h),
                    CustomFormTextField(
                      hintText: "Enter your password",
                      obscureText: true,
                      onChanged: (data) => password = data,
                    ),
                    verticalSpacing(25),
      
                    /// 🔷 Register Button
                    CustomButton(
                      text: "REGISTER",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                         cubit.registerUser( 
                          name: name??"Guest-user", 
                          email: email!,
                          password: password!, 
                          photoURL: profileImageUrl??"https://imgs.search.brave.com/r8_rpLtbGMxU9_hP_eV66IWtpYYaUuj62TaONvbGyA8/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly91cy4x/MjNyZi5jb20vNDUw/d20vYmxpbmtibGlu/azEvYmxpbmtibGlu/azEyMDA1L2JsaW5r/YmxpbmsxMjAwNTAw/MDE1LzE0Njk3OTQ2/NC1hdmF0YXItbWFu/bi1zeW1ib2wuanBn/P3Zlcj02"
                          );
                        }
                      },
                    ),
                    verticalSpacing(30),
      
                    /// 🔷 Divider
                    // OrWidget(),
                    // verticalSpacing(25),
      
                    // /// 🔷 Google Sign-in
                    // // GoogleBottom(
                    // //   onTap: ()async => await cubit.loginWithGoogle(),
                    // // ),
                    // verticalSpacing(25),
      
                    /// 🔷 Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
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
       
    );
  }
}
