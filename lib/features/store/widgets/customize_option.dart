import 'package:flutter/material.dart';

class CustomizeOption extends StatelessWidget {
  const CustomizeOption({super.key, required this.label, this.selection, required this.isSelected, this.onTap});

  final String label;
  final Widget? selection;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        // height: 50,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: isSelected? theme.primary: theme.secondary,
          borderRadius: BorderRadius.circular(100)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: isSelected? TextStyle(fontSize: 16, color: Colors.white) :TextStyle(fontSize: 16, color: theme.onSurface),),
            Row(children: [
              selection??SizedBox(),
              SizedBox(width: 10,),
              isSelected? Icon(Icons.check, color: Colors.white,): SizedBox(width: 20,)
            ],)
          ],
        ),
      ),
    );
  }
}