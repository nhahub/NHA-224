import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/widgets/app_bar_widget.dart';
import 'package:depi_final_project/features/personalization/ui/widget/inputField.dart';

class Addcard extends StatefulWidget {
  final String? id;
  final String? number;
  final String? name;
  final String? expire;
  final String? cvv;

  const Addcard({
    super.key,
    this.id,
    this.number,
    this.name,
    this.expire,
    this.cvv,
  });

  @override
  State<Addcard> createState() => _AddcardState();
}

class _AddcardState extends State<Addcard> {
  String? selectedMonth;
  String? selectedYear;

  List<String> years = List.generate(
    15,
    (i) => (DateTime.now().year + i).toString(),
  );

  List<String> months = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
  ];

  final formKey = GlobalKey<FormState>();

  final cardNumberController = TextEditingController();
  final cvvController = TextEditingController();
  final cardNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    /// لو جاي Edit → املا الفيلدز
    if (widget.id != null) {
      cardNumberController.text = widget.number ?? "";
      cardNameController.text = widget.name ?? "";
      cvvController.text = widget.cvv ?? "";

      if (widget.expire != null && widget.expire!.contains("/")) {
        selectedMonth = widget.expire!.split("/")[0];
        selectedYear = "20${widget.expire!.split("/")[1]}";
      }
    }
  }

  /// حفظ كارت جديد
  Future<void> saveCard() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      final data = {
        "Card Number": cardNumberController.text.trim(),
        "CVV": cvvController.text.trim(),
        "Exp": "${selectedMonth!}/${selectedYear!.substring(2)}",
        "Card Name": cardNameController.text.trim(),
        "createdAt": FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("card")
          .add(data);

      Navigator.pop(context);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Card Saved Successfully")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  /// تعديل الكارت
  Future<void> updateCard() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      final data = {
        "Card Number": cardNumberController.text.trim(),
        "CVV": cvvController.text.trim(),
        "Exp": "${selectedMonth!}/${selectedYear!.substring(2)}",
        "Card Name": cardNameController.text.trim(),
      };

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("card")
          .doc(widget.id)
          .update(data);

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Card Updated Successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Future<void> deleteCard() async {
    final confirm = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this card?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Yes"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("card")
          .doc(widget.id)
          .delete();

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Card Deleted Successfully")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.id != null;

    return Scaffold(
      appBar: CustomAppBar(title: isEditing ? "Card Details" : "Add Card"),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Inputfield(
                hintText: "Card Number",
                controller: cardNumberController,
                validator: (v) =>
                    v!.length != 16 ? "Card number must be 16 digits" : null,
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: Inputfield(
                      hintText: "CVV",
                      controller: cvvController,
                      validator: (v) =>
                          v!.length != 3 ? "CVV must be 3 digits" : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: selectedMonth,

                            decoration: InputDecoration(
                              labelText: "Month",
                              filled: true,
                              fillColor: Theme.of(
                                context,
                              ).inputDecorationTheme.fillColor,
                              labelStyle: Theme.of(
                                context,
                              ).inputDecorationTheme.labelStyle,
                              border: Theme.of(
                                context,
                              ).inputDecorationTheme.border,
                              enabledBorder: Theme.of(
                                context,
                              ).inputDecorationTheme.enabledBorder,
                              focusedBorder: Theme.of(
                                context,
                              ).inputDecorationTheme.focusedBorder,
                              errorBorder: Theme.of(
                                context,
                              ).inputDecorationTheme.errorBorder,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                            ),

                            dropdownColor: Theme.of(
                              context,
                            ).colorScheme.surface, // زي القايمة اللي بتفتح
                            iconEnabledColor: Theme.of(
                              context,
                            ).colorScheme.onSurface, // لون السهم

                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface, // لون النص
                              fontSize: 16,
                            ),

                            items: months.map((m) {
                              return DropdownMenuItem(
                                value: m,
                                child: Text(
                                  m,
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface, // نص القائمة
                                  ),
                                ),
                              );
                            }).toList(),

                            onChanged: (value) {
                              setState(() => selectedMonth = value);
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: selectedYear,

                            decoration: InputDecoration(
                              labelText: "Year",
                              filled: true,
                              fillColor: Theme.of(
                                context,
                              ).inputDecorationTheme.fillColor,
                              labelStyle: Theme.of(
                                context,
                              ).inputDecorationTheme.labelStyle,
                              border: Theme.of(
                                context,
                              ).inputDecorationTheme.border,
                              enabledBorder: Theme.of(
                                context,
                              ).inputDecorationTheme.enabledBorder,
                              focusedBorder: Theme.of(
                                context,
                              ).inputDecorationTheme.focusedBorder,
                              errorBorder: Theme.of(
                                context,
                              ).inputDecorationTheme.errorBorder,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                            ),

                            dropdownColor: Theme.of(
                              context,
                            ).colorScheme.surface,
                            iconEnabledColor: Theme.of(
                              context,
                            ).colorScheme.onSurface,

                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 16,
                            ),

                            items: years.map((y) {
                              return DropdownMenuItem(
                                value: y,
                                child: Text(
                                  y,
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                                ),
                              );
                            }).toList(),

                            onChanged: (value) {
                              setState(() => selectedYear = value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Inputfield(
                hintText: "Card Holder Name",
                controller: cardNameController,
                validator: (v) =>
                    v!.isEmpty ? "Card holder name required" : null,
              ),

              const Spacer(),

              if (isEditing)
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lightPrimary,
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            updateCard();
                          }
                        },
                        child: const Text("Update"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: deleteCard,
                        child: const Text("Delete"),
                      ),
                    ),
                  ],
                ),

              if (!isEditing)
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightPrimary,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        saveCard();
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
