import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/features/personalization/ui/widget/inputField.dart';
import 'package:flutter/material.dart';

class Addcard extends StatelessWidget {
  const Addcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Card",
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

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Inputfield(hintText: "Card Number"),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: Inputfield(hintText: "CCV")),
                const SizedBox(width: 12),
                Expanded(child: Inputfield(hintText: "Exp")),
              ],
            ),
            const SizedBox(height: 12),
            Inputfield(hintText: "Card Holder Name"),

            const Spacer(),
            SizedBox(
              // width:  MediaQuery.of(context).size.width * 0.5,
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
