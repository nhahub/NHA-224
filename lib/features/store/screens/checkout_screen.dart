import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// تأكد من الـ Imports الخاصة بمشروعك
import 'package:depi_final_project/features/store/widgets/app_bar_icon.dart';
import 'package:depi_final_project/features/store/widgets/checkout_item.dart';
import 'package:depi_final_project/features/personalization/cubit/orders_cubit.dart';
import 'package:depi_final_project/features/personalization/cubit/notifications_cubit.dart';
import 'package:depi_final_project/features/personalization/ui/screens/order_success_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. استقبال البيانات (لاحظ تطابق الأسماء مع ملف Cart)
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // إذا كانت args فارغة (null)، نستخدم 0 كقيمة افتراضية
    final double totalAmount = args?['totalPrice'] ?? 0.0;
    final int totalItems = args?['totalItems'] ?? 0;

    // طباعة للتأكد في الـ Debug Console
    print("Received in Checkout -> Price: $totalAmount, Items: $totalItems");

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Checkout",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: AppBarIcon(
            icon: "assets/icons/arrowleft.png",
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // العناصر العلوية (العنوان وطريقة الدفع)
            Column(
              children: const [
                CheckoutItem(
                  title: "Shipping address",
                  subtitle: "Add shipping address",
                  icon: "assets/icons/arrowright2.png",
                ),
                CheckoutItem(
                  title: "Payment method",
                  subtitle: "Add payment method",
                  icon: "assets/icons/arrowright2.png",
                ),
              ],
            ),

            // الزر السفلي والقيمة
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff8E6CEF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    // منع الطلب إذا كانت القيمة صفر (اختياري)
                    if (totalAmount == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Cart is empty or invalid amount!"),
                          backgroundColor: Colors.red.shade400,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                      return;
                    }

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    );

                    try {
                      // استخدام القيم المستلمة لإنشاء الطلب
                      final String orderId = await context
                          .read<OrdersCubit>()
                          .placeOrder(
                            total: totalAmount,
                            itemsCount: totalItems,
                          );

                      if (context.mounted) {
                        await context
                            .read<NotificationsCubit>()
                            .pushOrderPlaced(orderId);
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderSuccessScreen(),
                          ),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Error: $e"),
                            backgroundColor: Colors.red.shade400,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // عرض السعر هنا
                      Text(
                        "\$${totalAmount.toStringAsFixed(2)}",
                        style: GoogleFonts.gabarito(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Text("Place Order", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
