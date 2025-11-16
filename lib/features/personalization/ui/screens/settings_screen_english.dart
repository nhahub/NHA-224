import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:depi_final_project/core/theme/app_theme.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/theme/theme_manager.dart';
import 'package:depi_final_project/core/theme/bloc/theme_bloc.dart';
import 'package:depi_final_project/core/widgets/app_bar_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const CustomAppBar(
        title: 'Settings',
      ),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          AppTheme? currentTheme;

          if (themeState is LoadingThemeState) {
            currentTheme = themeState.appTheme;
          } else {
            // Assume user hasn't set a theme yet
            currentTheme = null;
          }

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildThemeSection(context, currentTheme),
              const SizedBox(height: 24),
              _buildAboutSection(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildThemeSection(BuildContext context, AppTheme? currentTheme) {
    return Card(
      elevation: Spacing.smElevation,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme',
              style: AppTextStyles.headline5.copyWith(
                fontFamily: 'Cairo',
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: Spacing.lg),
            // Light theme option
            _buildThemeOption(
              context,
              'Light Theme',
              currentTheme == AppTheme.light,
              () {
                context.read<ThemeBloc>().add(ChangeThemeEvent(AppTheme.light));
                ThemeManager().setThemeMode(ThemeMode.light);
              },
            ),
            SizedBox(height: Spacing.md),
            // Dark theme option
            _buildThemeOption(
              context,
              'Dark Theme',
              currentTheme == AppTheme.dark,
              () {
                context.read<ThemeBloc>().add(ChangeThemeEvent(AppTheme.dark));
                ThemeManager().setThemeMode(ThemeMode.dark);
              },
            ),
            SizedBox(height: Spacing.md),
            // Follow system option
            _buildThemeOption(
              context,
              'Follow System',
              currentTheme == null,
              () {
                ThemeManager().setThemeMode(ThemeMode.system);
                // Don't change the theme, follow system settings
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    String title,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Spacing.mdRadius),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(Spacing.mdRadius),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(
                fontFamily: 'Cairo',
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Card(
      elevation: Spacing.smElevation,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About App',
              style: AppTextStyles.headline5.copyWith(
                fontFamily: 'Cairo',
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: Spacing.lg),
            Text(
              'Khliha Alaina - App for students and teachers',
              style: AppTextStyles.bodyMedium.copyWith(
                fontFamily: 'Cairo',
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
