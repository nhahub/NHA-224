import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:depi_final_project/features/store/widgets/counter_btn.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.image, required this.price, required this.size, required this.color, required this.title});

  final String image;
  final String title;
  final double price;
  final String size;
  final String color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.secondary
      ),
      child: Row(
        
        children: [
        Image.network(image, width: 100, height: 100,fit: BoxFit.contain,),
        SizedBox(width: 5,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(title, overflow: TextOverflow.ellipsis,)),
                SizedBox(width: 50,),
                Text("\$$price", style: GoogleFonts.gabarito(textStyle: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 12
                )),)
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Size", style: TextStyle(color: Color.fromARGB(96, 39, 39, 128)),
                    children: [TextSpan(
                      text: " - $size",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                    )]),
                  
                ),
                SizedBox(width: 10,),
                RichText(
                  text: TextSpan(
                    text: "Color", style: TextStyle(color: Color.fromARGB(96, 39, 39, 128)),
                    children: [TextSpan(
                      text: " - $color",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                    )]),
                  
                ),
                SizedBox(width: 50,),
                CounterBtn(icon:"+"),
                SizedBox(width: 5,),
                CounterBtn(icon:"-"),
              ],
            ),
          ],
        )
      ],)

    );
  }
}