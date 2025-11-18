import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ProgressHUDWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final Widget? progressIndicator;
  final Color? progressIndicatorColor;
  final double? opacity;

  const ProgressHUDWidget({
    super.key,
    required this.child,
    required this.isLoading,
    this.progressIndicator,
    this.progressIndicatorColor,
    this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      opacity: opacity ?? 0.7,
      color: Colors.black.withOpacity(0.3),
      progressIndicator: progressIndicator ??
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: CircularProgressIndicator(
              color: progressIndicatorColor ?? AppColors.darkPrimary,
              strokeWidth: 3,
            ),
          ),
      child: child,
    );
  }
}

class LoadingOverlayHelper {
  static void show(
    BuildContext context, {
    String? message,
    Widget? customIndicator,
    Color? backgroundColor,
    double? opacity,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: Container(
          color: backgroundColor ?? Colors.black.withOpacity(0.3),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  customIndicator ??
                      CircularProgressIndicator(
                        color: AppColors.darkPrimary,
                        strokeWidth: 3,
                      ),
                  if (message != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
