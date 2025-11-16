import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/widgets/app_bar_widget.dart';
import 'package:depi_final_project/features/personalization/ui/widget/inputField.dart';

class AddAddressPage extends StatelessWidget {
  const AddAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        title: "Add Address",
      ),




      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Inputfield(hintText: "Street Address"),
            const SizedBox(height: 12),
            Inputfield(hintText: "City"),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: Inputfield(hintText: "State")),
                const SizedBox(width: 12),
                Expanded(child: Inputfield(hintText: "Zip Code")),
              ],
            ),
            const Spacer(),
            SizedBox(
              // width:  MediaQuery.of(context).size.width * 0.5,
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {},
                child: const Text("Save", style: TextStyle(color: Colors.white),)
              ),
            )
          ],
        ),
      ),
    );
  }
}