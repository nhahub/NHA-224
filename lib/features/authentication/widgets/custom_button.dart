import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButton extends StatelessWidget {
  final Color textColor;
  final Color background;
  final String textButton;
  final IconData icon;
  final VoidCallback? onPressed;
  const CustomButton({
    super.key,
    required this.textButton,
    this.icon = FontAwesomeIcons.google,
    this.textColor = const Color(0xffffffff),
    this.background = AppColors.lightPrimary,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          fixedSize: Size(400, 50),
          backgroundColor: background,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: background == Color(0xffffffff)
                  ? textColor
                  : Colors.transparent,
              width: 0, // عرض الخط
            ),
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
        child: Text(
                    textButton,
                    style: AppTextStyles.font17BlackMedium.copyWith(
                      color: textColor,
                    ),
              )
            
      ),
    );
  }
}
