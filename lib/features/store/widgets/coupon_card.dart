import 'package:flutter/material.dart';

class CouponCard extends StatelessWidget {
  const CouponCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
        color: theme.secondary,
        borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          leading: Image.asset("assets/icons/coupon_icon.png"),
          title: Text(
            "Enter coupon code",
            style: TextStyle(
              color: theme.onSurfaceVariant,
              fontSize: 14,
            ),
          ),
          trailing: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.primary,
              borderRadius: BorderRadius.circular(100),
            image: DecorationImage(image: AssetImage("assets/icons/arrowright.png"))),
            
          ),
        ),
      ),
    );
  }
}
