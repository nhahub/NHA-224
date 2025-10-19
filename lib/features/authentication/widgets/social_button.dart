import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:depi_final_project/shared/spacing.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialButton extends StatelessWidget {
  final Color textColor;
  final Color background;
  final String textButton;
  final IconData icon;
  final VoidCallback? onPressed;
  const SocialButton({
    super.key,
    required this.textButton,
    this.icon = FontAwesomeIcons.google,
    this.textColor = const Color(0xffffffff),
    this.background = AppColors.darkSecondary,
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
        child: background == Color(0xffffffff)
            ? Text(
                textButton,
                style: GoogleFonts.radioCanada(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(icon, color: textColor, size: 24),
                  ),
                  horizentalSpacing(30),
                  Text(
                    textButton,
                    style: AppTextStyles.font17BlackMedium.copyWith(
                      color: textColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
