import 'package:flutter/material.dart';
import 'package:depi_final_project/shared/spacing.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/features/authentication/widgets/custom_button.dart';
import 'package:depi_final_project/features/authentication/widgets/custom_text_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticaalSpacing(20),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.darkSecondary,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(10),
                      backgroundColor: AppColors.darkSecondary,
                    ),
                    child: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                verticaalSpacing(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Image.asset('assets/images/Ellipse 13.png'), Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.darkSecondary,
                  borderRadius: BorderRadius.circular(30),
                ),
                // child: DropdownButtonHideUnderline(
                //   child: DropdownButton<String>(
                //     dropdownColor: AppColors.darkSecondary,
                //     value: selectedAgeRange,
                //     hint: Text(
                //       'Age Range',
                //       style: AppTextStyles.font17WhiteMedium.copyWith(
                //         color: AppColors.darkTextSecondary,
                //         fontSize: 16,
                //       ),
                //     ),
                //     icon: const Icon(
                //       Icons.keyboard_arrow_down_rounded,
                //       color: Colors.white,
                //     ),
                //     items: ageRanges.map((String range) {
                //       return DropdownMenuItem<String>(
                //         value: range,
                //         child: Text(
                //           range,
                //           style: const TextStyle(color: Colors.white),
                //         ),
                //       );
                //     }).toList(),
                //     onChanged: (value) {
                //       setState(() {
                //         selectedAgeRange = value;
                //       });
                //     },
                //   ),
                // ),
              ),],
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
