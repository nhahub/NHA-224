import 'package:flutter/material.dart';

class ProductOption extends StatelessWidget {
  const ProductOption({super.key, required this.label, required this.options, this.onTap});
final String label;
final List<Widget> options;
final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),

        margin: EdgeInsets.only(top: 20, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: theme.secondary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(fontSize: 16),),
      
            Row(children: options)
          ],
        ),
      ),
    );
  }
}