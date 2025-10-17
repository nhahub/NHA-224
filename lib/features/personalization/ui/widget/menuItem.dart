import 'package:flutter/material.dart';

class Menuitem extends StatelessWidget {
  const Menuitem({super.key, required this.context, required this.title, required this.onTap});

  final BuildContext context;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
     return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16), 
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05), 
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  );
  }
} 