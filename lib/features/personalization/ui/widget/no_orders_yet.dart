import 'package:flutter/material.dart';
import 'package:depi_final_project/features/personalization/ui/widget/button.dart';


class NoOrdersYet extends StatelessWidget {
  const NoOrdersYet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/order.png", width: 100, height: 100),
          const SizedBox(height: 16),
          const Text(
            "No Orders yet",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          Button(text: "Explore Categories"),
        ],
      ),
    );
  }
}
