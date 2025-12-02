import 'package:flutter/material.dart';

class DealsBottomSheet extends StatelessWidget {
  const DealsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: const Text('Deals filter removed', style: TextStyle(fontSize: 16)),
    );
  }
}
