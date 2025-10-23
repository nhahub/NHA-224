import 'package:depi_final_project/features/store/widgets/app_bar_icon.dart';
import 'package:depi_final_project/features/store/widgets/checkout_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: AppBarIcon(icon: "assets/icons/arrowleft.png",onTap: (){},),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CheckoutItem(
                  title: "Shipping address",
                  subtitle: "Add shipping address",
                  icon: "assets/icons/arrowright2.png",
                ),
                CheckoutItem(
                  title: "Payment method",
                  subtitle: "Add payment method",
                  icon: "assets/icons/arrowright2.png",

                ),
              ],
            ),
        
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff8E6CEF),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                onPressed: (){}, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$208", style: GoogleFonts.gabarito(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),),
                    Text("Place Order", style: TextStyle(fontSize: 16),)
                  ],
                )),
              ],
            )
            ],
        ),
      ),
      
    );
  }
}