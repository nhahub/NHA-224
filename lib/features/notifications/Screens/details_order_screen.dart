import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  const OrderDetailsScreen({required this.orderId, super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> steps = [
      {'label': 'Delivered', 'date': '28 May', 'done': false},
      {'label': 'Shipped', 'date': '28 May', 'done': true},
      {'label': 'Order Confirmed', 'date': '28 May', 'done': true},
      {'label': 'Order Placed', 'date': '28 May', 'done': true},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Order $orderId",
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            ...steps.map(
              (step) => ListTile(
                leading: Icon(
                  Icons.circle,
                  color: step['done'] ? Colors.deepPurple : Colors.grey[300],
                  size: 16,
                ),
                title: Text(step['label']),
                trailing: Text(step['date']),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Order Items",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: const [
                  Icon(Icons.shopping_bag_outlined),
                  SizedBox(width: 10),
                  Text("4 items"),
                  Spacer(),
                  Text("View All", style: TextStyle(color: Colors.deepPurple)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Shipping details",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                "2715 Ash Dr. San Jose, South Dakota 83475\n121-224-7890",
                style: TextStyle(height: 1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
