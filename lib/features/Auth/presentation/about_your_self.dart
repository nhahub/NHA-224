import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
// import 'package:depi_final_project/features/Auth/presentation/widgets/custom_button.dart';

class AboutYourselfScreen extends StatefulWidget {
  const AboutYourselfScreen({super.key});

  @override
  State<AboutYourselfScreen> createState() => _AboutYourselfScreenState();
}

class _AboutYourselfScreenState extends State<AboutYourselfScreen> {
  String selectedGender = 'Men';
  String? selectedAgeRange;

  final List<String> ageRanges = [
    'Under 18',
    '18 - 24',
    '25 - 34',
    '35 - 44',
    '45 - 54',
    '55+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpacing(40),
              Text(
                'Tell us About yourself',
                style: AppTextStyles.font20WitekBold.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Who do you shop for ?',
                style: AppTextStyles.font17WhiteMedium,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGender = 'Men';
                        });
                      },
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: selectedGender == 'Men'
                              ? AppColors.darkPrimary
                              : AppColors.darkSecondary,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            'Men',
                            style: AppTextStyles.font17WhiteMedium.copyWith(
                              color: AppColors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGender = 'Women';
                        });
                      },
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: selectedGender == 'Women'
                              ? AppColors.darkPrimary
                              : AppColors.darkSecondary,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            'Women',
                            style: AppTextStyles.font17WhiteMedium.copyWith(
                              color: AppColors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpacing(40),
              Text('How Old are you ?', style: AppTextStyles.font17WhiteMedium),
              verticalSpacing(16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.darkSecondary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: AppColors.darkSecondary,
                    value: selectedAgeRange,
                    hint: Text(
                      'Age Range',
                      style: AppTextStyles.font17WhiteMedium.copyWith(
                        color: AppColors.darkTextSecondary,
                        fontSize: 16,
                      ),
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white,
                    ),
                    items: ageRanges.map((String range) {
                      return DropdownMenuItem<String>(
                        value: range,
                        child: Text(
                          range,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedAgeRange = value;
                      });
                    },
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF9B6BFF),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(),
              ),
              verticalSpacing(20),
            ],
          ),
        ),
      ),
    );
  }
}
