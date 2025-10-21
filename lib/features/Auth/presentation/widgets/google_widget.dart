
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoogleBottom extends StatelessWidget {
  const GoogleBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        minimumSize: Size(double.infinity, 52.h),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      onPressed: () async {
        // try {
        //   await authService.signInWithGoogle();
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //       content: Text('تم تسجيل الحساب بنجاح!'),
        //     ),
        //   );
        // } catch (e) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('خطأ: $e')),
        //   );
        // }
      },
      icon: Image.asset('assets/images/google.png', height: 24.h),
      label: Text(
        "Sign up with Google",
        style: AppTextStyles.font17BlackMedium,
      ),
    );
  }
}
