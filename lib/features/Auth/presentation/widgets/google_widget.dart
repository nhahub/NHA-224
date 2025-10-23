
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/features/Auth/cubit/auth_cubit.dart';
import 'package:depi_final_project/features/Auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoogleBottom extends StatelessWidget {
  const GoogleBottom({
    super.key, this.onTap,
  });

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
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
      onPressed: onTap,
      icon: Image.asset('assets/images/google.png', height: 24.h),
      label: Text(
        "Sign up with Google",
        style: AppTextStyles.font17BlackMedium,
      ),
    );
  }
}
