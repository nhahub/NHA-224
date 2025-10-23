import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/features/personalization/ui/screens/address.dart';
import 'package:depi_final_project/features/personalization/ui/screens/favourites.dart';
import 'package:depi_final_project/features/personalization/ui/screens/payment.dart';
import 'package:depi_final_project/features/personalization/ui/widget/menuItem.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                      },
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          "images/avatar1.png",
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
                          Text("Gilbert Jones",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
                      child: const Text("Edit", style: TextStyle(color: AppColors.lightPrimary)),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Menu Items
              Menuitem(context: context, title: "Address", onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddressPage()),
                );
              }),
              Menuitem(context: context, title: "My Favorites", onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Favourites()),
                );
              }),
              Menuitem(context: context, title: "Payment", onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PaymentPage()),
                );
              }),
              Menuitem(context: context, title: "Help", onTap: () {}),
              Menuitem(context: context, title: "Support", onTap: () {}),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {},
                child: const Text("Sign Out",
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
  
}