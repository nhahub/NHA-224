import 'package:flutter/material.dart';

class AppBarIcon extends StatelessWidget {
  const AppBarIcon({super.key,required this.icon,required this.onTap});

  final String icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: theme.secondary,
          borderRadius: BorderRadius.circular(100),
          image: DecorationImage(image: AssetImage(icon))
        ),
      ),
    );
  }
}