import 'package:flutter/material.dart';

class CounterBtn extends StatelessWidget {
  const CounterBtn({super.key, required this.icon, this.onTap});
  final String icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: Color(0xff8E6CEF),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Text(icon, style: TextStyle(fontSize: 24, color: Colors.white),),
      ),)
      
    );
  }
}