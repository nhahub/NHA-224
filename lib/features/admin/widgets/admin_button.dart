import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;

  const AdminButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        elevation: 3,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 30.sp),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
