import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depi_final_project/features/store/cubit/store_cubit.dart';

class SortBottomSheet extends StatefulWidget {
  const SortBottomSheet({super.key});

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  String? selectedSort;

  @override
  void initState() {
    super.initState();
    selectedSort = context.read<StoreCubit>().sort;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  setState(() => selectedSort = 'Recommended');
                  context.read<StoreCubit>().updateSort('Recommended');
                  Navigator.pop(context);
                },
                child: const Text("Clear"),
              ),
              const Text(
                "Sort by",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.check, size: 20),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, size: 20),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView(
              children: [
                _buildSortOption("Recommended", "Recommended"),
                _buildSortOption("Newest", "Newest"),
                _buildSortOption("Lowest - Highest Price", "Lowest Price"),
                _buildSortOption("Highest - Lowest Price", "Highest Price"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortOption(String label, String value) {
    final isSelected = selectedSort == value;
    return GestureDetector(
      onTap: () {
        setState(() => selectedSort = value);
        context.read<StoreCubit>().updateSort(value);
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Colors.purple : Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            if (isSelected) const Icon(Icons.check, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
