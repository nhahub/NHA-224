import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depi_final_project/features/store/cubit/store_cubit.dart';

class DealsBottomSheet extends StatefulWidget {
  const DealsBottomSheet({super.key});

  @override
  State<DealsBottomSheet> createState() => _DealsBottomSheetState();
}

class _DealsBottomSheetState extends State<DealsBottomSheet> {
  bool onSale = false;
  bool freeShipping = false;

  @override
  void initState() {
    super.initState();
    onSale = context.read<StoreCubit>().onSale;
    freeShipping = context.read<StoreCubit>().freeShipping;
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
                  setState(() {
                    onSale = false;
                    freeShipping = false;
                  });
                  context.read<StoreCubit>().updateDeals(false, false);
                  Navigator.pop(context);
                },
                child: const Text("Clear"),
              ),
              const Text(
                "Deals",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
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
                _buildDealOption("On sale", onSale, (value) => setState(() => onSale = value)),
                _buildDealOption("Free Shipping Eligible", freeShipping, (value) => setState(() => freeShipping = value)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDealOption(String title, bool isSelected, ValueChanged<bool> onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!isSelected),
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
              title,
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

  @override
  void dispose() {
    context.read<StoreCubit>().updateDeals(onSale, freeShipping);
    super.dispose();
  }
}
