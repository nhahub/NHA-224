import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/features/Auth/presentation/widgets/custom_button.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/image 4.png'),
          verticalSpacing(30),
          Text(
            'Check your Email. We sent you an Email to reset your password.',
            style: AppTextStyles.font17BlackRegular.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          verticalSpacing(20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: CustomButton(
              text: 'Back to login In',
              onTap: () {
                Navigator.pop(context); // close dialog
                Navigator.pushNamed(context, AppRoutes.login);
              },
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
