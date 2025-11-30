import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/widgets/app_bar_widget.dart';
import 'package:depi_final_project/features/personalization/ui/widget/inputField.dart';

class AddAddressPage extends StatefulWidget {
  final String? id;
  final String? street;
  final String? city;
  final String? state;
  final String? zip;

  const AddAddressPage({
    super.key,
    this.id,
    this.street,
    this.city,
    this.state,
    this.zip,
  });

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final formKey = GlobalKey<FormState>();

  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();

  @override
  void initState() {
    super.initState();

    streetController.text = widget.street ?? "";
    cityController.text = widget.city ?? "";
    stateController.text = widget.state ?? "";
    zipController.text = widget.zip ?? "";
  }

  Future<void> saveAddress() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      final data = {
        "street": streetController.text.trim(),
        "city": cityController.text.trim(),
        "state": stateController.text.trim(),
        "zip": zipController.text.trim(),
        "createdAt": FieldValue.serverTimestamp(),
      };

      if (widget.id == null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .collection("address")
            .add(data);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Address Added Successfully")),
        );
      } else {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .collection("address")
            .doc(widget.id)
            .update(data);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Address Updated Successfully")),
        );
      }

      Navigator.pop(context);

    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  String? addressValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required";
    }

    if (!RegExp(r'^[a-zA-Z0-9\s\-\,\.]+$').hasMatch(value)) {
      return "Invalid characters";
    }

    return null;
  }

  String? zipValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "ZIP code is required";
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return "ZIP code must be numbers only";
    }

    if (value.length < 3 || value.length > 10) {
      return "Invalid ZIP code length";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: widget.id == null ? "Add Address" : "Edit Address"),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Inputfield(
                hintText: "Street Address",
                controller: streetController,
                validator: addressValidator,
              ),
              const SizedBox(height: 12),
              Inputfield(
                hintText: "City",
                controller: cityController,
                validator: addressValidator,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Inputfield(
                      hintText: "State",
                      controller: stateController,
                      validator: addressValidator,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Inputfield(
                      hintText: "Zip Code",
                      controller: zipController,
                      validator: zipValidator,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 40,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      saveAddress();
                    }
                  },
                  child: Text(
                    widget.id == null ? "Save" : "Update",
                    style: const TextStyle(color: Colors.white),
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
