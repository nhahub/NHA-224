import 'package:flutter/material.dart';
import 'package:depi_final_project/shared/spacing.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/features/authentication/widgets/custom_button.dart';

class EmailSent extends StatelessWidget {
  const EmailSent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/image 4.png'),
          verticaalSpacing(30),
          Text(
            'We Sent you an Email to reset your password.',
            style: AppTextStyles.font20WitekBold.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          verticaalSpacing(20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 90),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to sign-in screen
              },
              child: CustomButton(textButton: 'Back to Sign In'),
            ),
          ),
        ],
      ),
    );
  }
}
