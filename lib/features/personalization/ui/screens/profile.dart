import 'package:depi_final_project/features/Auth/presentation/login_page.dart';
import 'package:depi_final_project/features/personalization/ui/screens/favorite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/features/personalization/ui/screens/address.dart';
import 'package:depi_final_project/features/personalization/ui/screens/payment.dart';
import 'package:depi_final_project/features/personalization/ui/widget/menuItem.dart';
import 'package:depi_final_project/features/personalization/cubit/personalization_cubit.dart';
import 'package:depi_final_project/features/personalization/cubit/personalization_state.dart';
import 'package:depi_final_project/features/personalization/ui/screens/settings_screen_english.dart';
// import 'package:depi_final_project/core/errors/failures.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String imageUrl;

  @override
  void initState() {
    // TODO: implement initState
    context.read<PersonalizationCubit>().loadUserImage();
    context.read<PersonalizationCubit>().loadUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PersonalizationCubit>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<PersonalizationCubit, PersonalizationState>(
            listener: (context, state) {
              if (state is PersonalizationSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Profile edited successfully")),
                );
              } else if (state is PersonalizationFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            cubit.uploadImage();
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: state is PersonalizationLoaded
                                ? NetworkImage(state.imageUrl)
                                : state is PersonalizationSuccess
                                ? NetworkImage(state.imageUrl)
                                : NetworkImage(
                                    "https://imgs.search.brave.com/r8_rpLtbGMxU9_hP_eV66IWtpYYaUuj62TaONvbGyA8/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly91cy4x/MjNyZi5jb20vNDUw/d20vYmxpbmtibGlu/azEvYmxpbmtibGlu/azEyMDA1L2JsaW5r/YmxpbmsxMjAwNTAw/MDE1LzE0Njk3OTQ2/NC1hdmF0YXItbWFu/bi1zeW1ib2wuanBn/P3Zlcj02",
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Info Container
                  Container(
                    padding: EdgeInsets.all(Spacing.md),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(Spacing.lgRadius),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Name & Email
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state is PersonalizationLoadedd
                                    ? state.name
                                    : "Loading...",
                                style: AppTextStyles.headline6.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                              SizedBox(height: Spacing.xs),
                              Text(
                                state is PersonalizationLoadedd
                                    ? state.email
                                    : "",
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Edit Button
                        TextButton(
onPressed: () {
  if (state is PersonalizationLoadedd) {
    showEditNameDialog(context, state.name);
  }
},
                          child: Text(
                            "Edit",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Menu Items
                  Menuitem(
                    context: context,
                    title: "Settings",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                  Menuitem(
                    context: context,
                    title: "Address",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AddressPage()),
                      );
                    },
                  ),
                  Menuitem(
                    context: context,
                    title: "My Favorites",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => FavoriteScreen()),
                      );
                    },
                  ),
                  Menuitem(
                    context: context,
                    title: "Payment",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PaymentPage()),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
TextButton(
  onPressed: () async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
      (route) => false, // يمسح كل الصفحات اللي فاتت
    );
  },
  child: const Text(
    "Sign Out",
    style: TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold,
    ),
  ),
)

                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

void showEditNameDialog(BuildContext context, String currentName) {
  final TextEditingController controller =
      TextEditingController(text: currentName);
  showDialog(
  context: context,
  builder: (context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(
        "Edit Name",
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      content: TextField(
        controller: controller,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface, // اللون في دارك/لايت
        ),
        decoration: InputDecoration(
          labelText: "New Name",
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant, // لون اللابل
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5,
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),

        ElevatedButton(
          onPressed: () {
            String newName = controller.text.trim();
            if (newName.isEmpty) return;

            context.read<PersonalizationCubit>().updateName(newName);
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
          child: const Text("Save"),
        ),
      ],
    );
  },
);

}
