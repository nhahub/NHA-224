import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/features/personalization/ui/screens/address.dart';
import 'package:depi_final_project/features/personalization/ui/screens/payment.dart';
import 'package:depi_final_project/features/personalization/ui/widget/menuItem.dart';
import 'package:depi_final_project/features/personalization/ui/screens/favourites.dart';
import 'package:depi_final_project/features/personalization/cubit/personalization_cubit.dart';
import 'package:depi_final_project/features/personalization/cubit/personalization_state.dart';
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
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // Name & Email
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Gilbert Jones",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text("Gilbertjones001@gmail.com"),
                              SizedBox(height: 2),
                              Text("121-224-7890"),
                            ],
                          ),
                        ),
                        // Edit Button
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Edit",
                            style: TextStyle(color: AppColors.lightPrimary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Menu Items
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
                        MaterialPageRoute(builder: (_) => const Favourites()),
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
                  Menuitem(context: context, title: "Help", onTap: () {}),
                  Menuitem(context: context, title: "Support", onTap: () {}),

                  const SizedBox(height: 20),

                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Sign Out",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
