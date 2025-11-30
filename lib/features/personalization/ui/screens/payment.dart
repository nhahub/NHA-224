import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/widgets/app_bar_widget.dart';
import 'package:depi_final_project/features/personalization/ui/screens/addCard.dart';
import 'package:depi_final_project/features/personalization/ui/widget/payMentCard.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: const CustomAppBar(title: "Payment"),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Cards",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: AppColors.lightPrimary),),
            const SizedBox(height: 12),

            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(userId)
                    .collection("card")
                    .orderBy("createdAt", descending: false)
                    .snapshots(),

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No cards added yet",style: TextStyle(color:AppColors.lightPrimary ),));
                  }

                  final docs = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final card = docs[index];
                      final id = card.id;
                      final number = card["Card Number"];

                      final last4 = number.substring(number.length - 4);

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>Addcard(
                                id: id,
                                number: card["Card Number"],
                                name: card["Card Name"],
                                expire: card["Exp"],
                                cvv: card["CVV"],
                              ),
                            ),
                          );
                        },
                        child: Paymentcard(text: "**** $last4"),
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Addcard()),
                    );
                  },
                  child: const Text("Add Card",
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
