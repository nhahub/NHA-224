import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final double? elevation;
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
      scrolledUnderElevation: 0,
      backgroundColor:
          backgroundColor ?? Theme.of(context).colorScheme.background,
      foregroundColor:
          foregroundColor ?? Theme.of(context).colorScheme.onBackground,
      elevation: elevation,
      title: title != null
          ? Text(
              title!,
              style: AppTextStyles.headline6.copyWith(
                fontWeight: FontWeight.bold,
                color:
                    foregroundColor ??
                    Theme.of(context).colorScheme.onBackground,
              ),
            )
          : null,
      centerTitle: centerTitle,
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
