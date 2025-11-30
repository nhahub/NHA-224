import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/widgets/app_bar_widget.dart';
import 'package:depi_final_project/features/personalization/ui/screens/addAddress.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: CustomAppBar(title: "Address"),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(userId)
                    .collection("address")
                    .orderBy("createdAt", descending: false)
                    .snapshots(),

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Addresses Added Yet",
                        style: TextStyle(color: AppColors.lightPrimary),
                      ),
                    );
                  }

                  final docs = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final address = docs[index];

                      final id = address.id;
                      final street = address["street"];
                      final city = address["city"];
                      final state = address["state"];
                      final zip = address["zip"];

                      final controller = TextEditingController(
                        text: "$street, $city, $state, $zip",
                      );

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextField(
                          controller: controller,
                          readOnly: true,

                          style: TextStyle(
                            color: theme.colorScheme.onSurface,
                            fontSize: 16,
                          ),

                          decoration: InputDecoration(
                            filled: true,
                            fillColor: theme.inputDecorationTheme.fillColor,

                            border: theme.inputDecorationTheme.border,
                            enabledBorder: theme.inputDecorationTheme.enabledBorder,
                            focusedBorder: theme.inputDecorationTheme.focusedBorder,

                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),

                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: theme.colorScheme.primary,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => AddAddressPage(
                                          id: id,
                                          street: street,
                                          city: city,
                                          state: state,
                                          zip: zip,
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          title: const Text("Confirm Delete"),
                                          content: const Text(
                                            "Are you sure you want to delete this address?",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("No"),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                Navigator.pop(context);

                                                await FirebaseFirestore.instance
                                                    .collection("users")
                                                    .doc(userId)
                                                    .collection("address")
                                                    .doc(id)
                                                    .delete();
                                              },
                                              child: const Text(
                                                "Yes",
                                                style: TextStyle(color: Colors.red),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
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
                      MaterialPageRoute(builder: (_) => const AddAddressPage()),
                    );
                  },
                  child: const Text(
                    "Add Address",
                    style: TextStyle(color: Colors.white),
                  ),
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
