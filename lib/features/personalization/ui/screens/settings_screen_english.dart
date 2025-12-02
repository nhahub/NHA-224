import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:depi_final_project/core/theme/app_theme.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/theme/theme_manager.dart';
import 'package:depi_final_project/core/theme/bloc/theme_bloc.dart';
import 'package:depi_final_project/core/widgets/app_bar_widget.dart';
import 'package:depi_final_project/features/Auth/presentation/login_page.dart';
import 'package:depi_final_project/features/personalization/cubit/personalization_cubit.dart';
import 'package:depi_final_project/features/personalization/cubit/personalization_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PersonalizationCubit>().loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Settings',
      ),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          AppTheme? currentTheme;

          if (themeState is LoadingThemeState) {
            currentTheme = themeState.appTheme;
          } else {
            currentTheme = null;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileSection(context),
                const SizedBox(height: 24),
                _buildThemeSection(context, currentTheme),
                const SizedBox(height: 24),
                _buildAccountSection(context),
                const SizedBox(height: 24),
                _buildSupportSection(context),
                const SizedBox(height: 24),
                _buildAboutSection(context),
              ],
            ),
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

  Widget _buildProfileSection(BuildContext context) {
    return Card(
      elevation: Spacing.smElevation,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: AppTextStyles.headline5.copyWith(
                fontFamily: 'Cairo',
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: Spacing.lg),
            BlocBuilder<PersonalizationCubit, PersonalizationState>(
              builder: (context, state) {
                String? imageUrl;
                String name = "Loading...";
                String email = "";

                if (state is PersonalizationDataLoaded) {
                  name = state.name;
                  email = state.email;
                  imageUrl = state.imageUrl;
                } else if (state is PersonalizationLoaded) {
                  imageUrl = state.imageUrl;
                } else if (state is PersonalizationSuccess) {
                  imageUrl = state.imageUrl;
                }

                if (state is PersonalizationLoadedd) {
                  name = state.name;
                  email = state.email;
                }

                return Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: imageUrl != null
                          ? NetworkImage(imageUrl)
                          : null,
                      child: imageUrl == null
                          ? Icon(Icons.person, color: Theme.of(context).colorScheme.onSurface)
                          : null,
                    ),
                    SizedBox(width: Spacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: AppTextStyles.headline6.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: Spacing.xs),
                          Text(
                            email,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => _showEditProfileDialog(context, state),
                      icon: Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    return Card(
      elevation: Spacing.smElevation,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account',
              style: AppTextStyles.headline5.copyWith(
                fontFamily: 'Cairo',
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: Spacing.lg),
            _buildSettingOption(
              context,
              'Change Password',
              Icons.lock,
              () => _showChangePasswordDialog(context),
            ),
            SizedBox(height: Spacing.sm),
            _buildSettingOption(
              context,
              'Privacy Settings',
              Icons.privacy_tip,
              () => _showPrivacySettings(context),
            ),
            SizedBox(height: Spacing.sm),
            _buildSettingOption(
              context,
              'Notification Settings',
              Icons.notifications,
              () => _showNotificationSettings(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportSection(BuildContext context) {
    return Card(
      elevation: Spacing.smElevation,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Support & Help',
              style: AppTextStyles.headline5.copyWith(
                fontFamily: 'Cairo',
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: Spacing.lg),
            _buildSettingOption(
              context,
              'Help Center',
              Icons.help,
              () => _showHelpCenter(context),
            ),
            SizedBox(height: Spacing.sm),
            _buildSettingOption(
              context,
              'Contact Support',
              Icons.support,
              () => _showContactSupport(context),
            ),
            SizedBox(height: Spacing.sm),
            _buildSettingOption(
              context,
              'Report a Problem',
              Icons.report,
              () => _showReportProblem(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingOption(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Spacing.mdRadius),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.sm,
          vertical: Spacing.md,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
            SizedBox(width: Spacing.md),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontFamily: 'Cairo',
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 16,
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
            SizedBox(height: Spacing.md),
            Text(
              'Version 1.0.0',
              style: AppTextStyles.bodySmall.copyWith(
                fontFamily: 'Cairo',
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, PersonalizationState state) {
    final TextEditingController nameController = TextEditingController(
      text: state is PersonalizationLoadedd ? state.name : "",
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Tap your profile picture above to change your avatar",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Spacing.lg),
            TextField(
              controller: nameController,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              decoration: InputDecoration(
                labelText: "Full Name",
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String newName = nameController.text.trim();
              if (newName.isNotEmpty) {
                context.read<PersonalizationCubit>().updateName(newName);
              }
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    // Implement change password dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Change password feature coming soon!",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showPrivacySettings(BuildContext context) {
    // Implement privacy settings
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Privacy settings coming soon!",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showNotificationSettings(BuildContext context) {
    // Implement notification settings
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Notification settings coming soon!",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showHelpCenter(BuildContext context) {
    // Implement help center
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Help center coming soon!",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showContactSupport(BuildContext context) {
    // Implement contact support
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Contact support coming soon!",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showReportProblem(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Report problem feature coming soon!",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
