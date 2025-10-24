import 'package:flutter/material.dart';
import 'package:depi_final_project/features/personalization/ui/widget/have_orders.dart';
import 'package:depi_final_project/features/personalization/ui/widget/no_orders_yet.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  final List<Map<String, dynamic>> dummyOrdersData = const [
    // {'id': '#456765', 'items': 4, 'status': 'Processing'},
    // {'id': '#454569', 'items': 2, 'status': 'Processing'},
    // {'id': '#454809', 'items': 1, 'status': 'Processing'},
  ];

  @override
  Widget build(BuildContext context) {
    final bool hasOrders = dummyOrdersData.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text("Orders", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: hasOrders
          ? HaveOrdersScreen(orders: dummyOrdersData)
          : NoOrdersYet(),
    );
  }
}
