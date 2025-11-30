import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> orderData;

  const OrderDetailsScreen({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    // تنسيق بسيط للتاريخ (بياخد أول جزء من التاريخ yyyy-mm-dd)
    final date = orderData['createdAt'] != null 
        ? orderData['createdAt'].toString().split('T')[0] 
        : DateTime.now().toString().split(' ')[0];
    
    final status = orderData['status'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"), // أو ممكن تحط رقم الطلب
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             // عنوان برقم الطلب
            Center(
              child: Text(
                "Order #${orderData['orderId']}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),

            // 1. التايم لاين (Timeline)
            _buildTimelineStep(
              title: "Delivered",
              date: "Expected", // ممكن تعدلها لو عندك تاريخ توصيل
              isActive: status == "Delivered",
              isLast: false,
            ),
            _buildTimelineStep(
              title: "Shipped",
              date: "",
              isActive: status == "Shipped" || status == "Delivered",
              isLast: false,
            ),
            _buildTimelineStep(
              title: "Order Confirmed",
              date: "",
              isActive: true, // دايماً مفعل طالما الطلب اتعمل
              isLast: false,
            ),
            _buildTimelineStep(
              title: "Order Placed",
              date: date,
              isActive: true,
              isLast: true, // آخر خطوة عشان نشيل الخط اللي تحتها
            ),

            const SizedBox(height: 40),

            // 2. قسم العناصر (Order Items)
            const Text(
              "Order Items",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 16),
            
            // كارت يعرض عدد المنتجات
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.receipt_outlined, size: 28, color: Color(0xff8E6CEF)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      "${orderData['itemsCount']} items",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // هنا ممكن تفتح صفحة تانية فيها لستة المنتجات لو حابب
                    },
                    child: const Text(
                      "View All",
                      style: TextStyle(color: Color(0xff8E6CEF), fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            
            // تفاصيل الدفع (اختياري)
            const SizedBox(height: 20),
            const Text(
              "Order Info",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Amount", style: TextStyle(color: Colors.grey)),
                Text("\$${orderData['total']}", style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ويدجت لرسم كل خطوة في التايم لاين
  Widget _buildTimelineStep({
    required String title,
    required String date,
    required bool isActive,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            // الدائرة
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xff8E6CEF) : Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: isActive
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            // الخط الرأسي
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isActive ? const Color(0xff8E6CEF) : Colors.grey[200],
              ),
          ],
        ),
        const SizedBox(width: 16),
        // النصوص
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: isActive ? Colors.black : Colors.grey,
                    ),
                  ),
                  if (date.isNotEmpty)
                    Text(
                      date,
                      style: TextStyle(
                        color: isActive ? Colors.black54 : Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 40), // مسافة لتعويض ارتفاع الخط
            ],
          ),
        ),
      ],
    );
  }
}