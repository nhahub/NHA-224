import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessfulOrder extends StatelessWidget {
  const SuccessfulOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8E6CEF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset("assets/images/orderSuccess.png"),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16) ),
                color: Color(0xffF4F4F4)
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 20,),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Order placed\nSuccessfully", style: GoogleFonts.gabarito(textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32
                        )),),
                        SizedBox(height: 10,),
                        Text("You will receive an email confirmation", style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(124, 39, 39, 128)
                        ),),
                      ],
                    ),
                
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff8E6CEF),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    textStyle: TextStyle(fontSize: 16)),
                        onPressed: (){},
                        child: Text("See order details")),
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}