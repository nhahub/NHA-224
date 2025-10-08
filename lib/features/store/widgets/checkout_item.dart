import 'package:flutter/material.dart';

class CheckoutItem extends StatelessWidget {
  const CheckoutItem({super.key, required this.title, required this.subtitle, required this.icon});

  final String title;
  final String subtitle;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffF4F4F4)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 12, color: Color.fromARGB(105, 39, 39, 128)),),
              SizedBox(height: 5,),
              Text(subtitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            ],
          ),

          InkWell(child: Image.asset(icon, width: 50, height: 50,))
        ],
      ),
    );
  }
}