import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/theme/text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final double elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.centerTitle = true,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.elevation = 0.5,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor:
          backgroundColor ?? Theme.of(context).colorScheme.background,
      foregroundColor:
          foregroundColor ?? Theme.of(context).colorScheme.onBackground,
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,

      // ---------- Leading (Back Button) ----------
      leading: automaticallyImplyLeading
          ? Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 40.h,
                  width: 40.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18.sp,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            )
          : (leading != null
                ? Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: leading,
                  )
                : null),

      // ---------- Title ----------
      title: title != null
          ? Text(
              title!,
              style: AppTextStyles.headline5.copyWith(
                fontWeight: FontWeight.bold,
                color:
                    foregroundColor ??
                    Theme.of(context).colorScheme.onBackground,
              ),
            )
          : null,

      // ---------- Actions ----------
      actions: actions != null ? [...actions!, SizedBox(width: 20.w)] : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
