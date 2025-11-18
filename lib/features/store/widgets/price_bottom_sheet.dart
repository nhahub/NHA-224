import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depi_final_project/features/store/cubit/store_cubit.dart';

class PriceBottomSheet extends StatefulWidget {
  const PriceBottomSheet({super.key});

  @override
  State<PriceBottomSheet> createState() => _PriceBottomSheetState();
}

class _PriceBottomSheetState extends State<PriceBottomSheet> {
  final TextEditingController minController = TextEditingController();
  final TextEditingController maxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<StoreCubit>();
    minController.text = cubit.minPriceSel?.toString() ?? '';
    maxController.text = cubit.maxPriceSel?.toString() ?? '';
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
                      minController.clear();
                      maxController.clear();
                    });
                    context.read<StoreCubit>().updatePrice(null, null);
                    Navigator.pop(context);
                  },
                  child: const Text("Clear"),
                ),
                const Text(
                  "Price",
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
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Min"),
                          TextField(
                            controller: minController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '0',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Max"),
                          TextField(
                            controller: maxController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '1000',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _applyPrice() {
    final min = minController.text.isEmpty ? null : double.tryParse(minController.text);
    final max = maxController.text.isEmpty ? null : double.tryParse(maxController.text);
    context.read<StoreCubit>().updatePrice(min, max);
  }

  @override
  void dispose() {
    minController.dispose();
    maxController.dispose();
    _applyPrice();
    super.dispose();
  }
}
