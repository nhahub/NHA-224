import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class EmpityWidgets extends StatelessWidget {
  const EmpityWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: 342,

            // height: 290,
            child: Column(
              children: [
                Spacer(),
                Image.asset(
                  "assets/images/search 1.png",
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 12),
                Text(
                  "Sorry, we couldn't find any matching result for your Search.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.darkTextSecondary,
                    // fontFamily: "Circular Std",
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 24,
                    height: 1.0,
                    letterSpacing: 0,
                  ),
                ),

                SizedBox(height: 12),

                TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      AppColors.lightPrimary,
                    ), // الخلفية
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Explore Categories",
                    style: AppTextStyles.font17WiteRegular,
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
