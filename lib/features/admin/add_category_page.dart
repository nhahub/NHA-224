import 'dart:io';
import '../../core/config.dart';
import 'package:flutter/material.dart';
import '../../core/widgets/app_bar_widget.dart';
import '../../data/models/category_model.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/services/category_service.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  File? _pickedImage;
  bool _loading = false;
  final CategoryService _service = CategoryService(
    cloudinaryCloudName: kCloudinaryCloudName,
    cloudinaryUploadPreset: kCloudinaryUploadPreset,
  );

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      imageQuality: 80,
    );
    if (file != null) {
      setState(() {
        _pickedImage = File(file.path);
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_pickedImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select an image.')));
      return;
    }

    setState(() => _loading = true);
    try {
      final model = CategoryModel(
        id: '',
        name: _nameController.text.trim(),
        imageUrl: '',
        createdAt: DateTime.now(),
      );
      await _service.addCategory(model, imageFile: _pickedImage);
      setState(() => _loading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Category added')));
      Navigator.of(context).pop();
    } catch (e) {
      setState(() => _loading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Category'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Category name'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Enter category name'
                    : null,
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _pickImage,
                child: _pickedImage == null
                    ? Container(
                        height: 140,
                        color: Colors.grey[200],
                        child: const Center(child: Text('Tap to pick image')),
                      )
                    : Image.file(_pickedImage!, height: 140, fit: BoxFit.cover),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loading ? null : _submit,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
