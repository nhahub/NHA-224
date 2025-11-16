import 'dart:io';
import '../../core/config.dart';
import 'package:flutter/material.dart';
import '../../core/widgets/app_bar_widget.dart';
import '../../data/models/product_model.dart';
import '../../data/models/category_model.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/services/product_service.dart';
import '../../data/services/category_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _oldPriceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController(
    text: '0',
  );
  final TextEditingController _colorsController = TextEditingController();
  final TextEditingController _sizesController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();

  String _gender = 'Unspecified';
  CategoryModel? _selectedCategory;
  List<File> _images = [];
  bool _loading = false;

  final CategoryService _categoryService = CategoryService(
    cloudinaryCloudName: kCloudinaryCloudName,
    cloudinaryUploadPreset: kCloudinaryUploadPreset,
  );
  final ProductService _productService = ProductService(
    cloudinaryCloudName: kCloudinaryCloudName,
    cloudinaryUploadPreset: kCloudinaryUploadPreset,
  );

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final List<XFile>? files = await picker.pickMultiImage(
      imageQuality: 80,
      maxWidth: 1600,
    );
    if (files != null && files.isNotEmpty) {
      setState(() {
        _images = files.map((e) => File(e.path)).toList();
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one image')),
      );
      return;
    }

    final name = _nameController.text.trim();
    final desc = _descriptionController.text.trim();
    final price = double.tryParse(_priceController.text.trim()) ?? 0.0;
    final oldPrice = double.tryParse(_oldPriceController.text.trim());
    final stock = int.tryParse(_stockController.text.trim()) ?? 0;
    final colors = _colorsController.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    final sizes = _sizesController.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    if (price <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Price must be > 0')));
      return;
    }

    setState(() => _loading = true);
    try {
      final product = ProductModel(
        id: '',
        name: name,
        description: desc,
        price: price,
        oldPrice: oldPrice,
        rating: 0.0,
        stock: stock,
        productId: '',
        colors: colors,
        sizes: sizes,
        imageUrl: [],
        category: _selectedCategory != null
            ? FirebaseFirestore.instance
                  .collection('categories')
                  .doc(_selectedCategory!.id)
            : null,
        gender: _gender,
        brand: _brandController.text.trim().isEmpty
            ? null
            : _brandController.text.trim(),
        sku: _skuController.text.trim().isEmpty
            ? null
            : _skuController.text.trim(),
        isFeatured: false,
        createdAt: DateTime.now(),
      );

      await _productService.addProduct(product, imageFiles: _images);
      setState(() => _loading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Product added')));
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
      appBar: const CustomAppBar(title: 'Add Product'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Product name'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Enter product name'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 4,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Enter description'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (v) =>
                    (v == null ||
                        double.tryParse(v) == null ||
                        double.parse(v) <= 0)
                    ? 'Enter valid price'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _oldPriceController,
                decoration: const InputDecoration(
                  labelText: 'Old price (optional)',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _stockController,
                decoration: const InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _colorsController,
                decoration: const InputDecoration(
                  labelText: 'Colors (comma separated)',
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _sizesController,
                decoration: const InputDecoration(
                  labelText: 'Sizes (comma separated)',
                ),
              ),
              const SizedBox(height: 12),
              FutureBuilder<List<CategoryModel>>(
                future: _categoryService.getAllCategories(),
                builder: (context, snap) {
                  final cats = snap.data ?? [];
                  return DropdownButtonFormField<CategoryModel>(
                    value: _selectedCategory,
                    items: cats
                        .map(
                          (c) =>
                              DropdownMenuItem(value: c, child: Text(c.name)),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _selectedCategory = v),
                    decoration: const InputDecoration(labelText: 'Category'),
                  );
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _gender,
                items: const [
                  DropdownMenuItem(
                    value: 'Unspecified',
                    child: Text('Unspecified'),
                  ),
                  DropdownMenuItem(value: 'Men', child: Text('Men')),
                  DropdownMenuItem(value: 'Women', child: Text('Women')),
                ],
                onChanged: (v) => setState(() => _gender = v ?? 'Unspecified'),
                decoration: const InputDecoration(labelText: 'Gender'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _brandController,
                decoration: const InputDecoration(
                  labelText: 'Brand (optional)',
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _skuController,
                decoration: const InputDecoration(labelText: 'SKU (optional)'),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImages,
                child: _images.isEmpty
                    ? Container(
                        height: 140,
                        color: Colors.grey[200],
                        child: const Center(child: Text('Tap to pick images')),
                      )
                    : SizedBox(
                        height: 140,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _images.length,
                          itemBuilder: (context, i) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Image.file(
                              _images[i],
                              width: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _loading ? null : _submit,
                      child: _loading
                          ? const CircularProgressIndicator()
                          : const Text('Save Product'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: _loading
                        ? null
                        : () {
                            _formKey.currentState?.reset();
                            _nameController.clear();
                            _descriptionController.clear();
                            _priceController.clear();
                            _oldPriceController.clear();
                            _stockController.text = '0';
                            _colorsController.clear();
                            _sizesController.clear();
                            _brandController.clear();
                            _skuController.clear();
                            setState(() {
                              _images = [];
                              _selectedCategory = null;
                              _gender = 'Unspecified';
                            });
                          },
                    child: const Text('Clear Form'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
