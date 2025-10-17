import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/features/personalization/ui/screens/addAddress.dart';
import 'package:depi_final_project/features/personalization/ui/widget/adressWidget.dart';
import 'package:flutter/material.dart'; 

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Address",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Adresswidget(address: "2715 Ash Dr. San Jose, South Dakota"),
          const Adresswidget(address: "2715 Ash Dr. San Jose, South Dakota"),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddAddressPage()),
                  );
                },
                child: const Text(
                  "Add Address",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
