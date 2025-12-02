import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/features/store/cubit/store_cubit.dart';

class PriceBottomSheet extends StatefulWidget {
  const PriceBottomSheet({super.key});

  @override
  State<PriceBottomSheet> createState() => _PriceBottomSheetState();
}

class _PriceBottomSheetState extends State<PriceBottomSheet> {
  final TextEditingController minController = TextEditingController();
  final TextEditingController maxController = TextEditingController();
  late double? originalMinPrice;
  late double? originalMaxPrice;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<StoreCubit>();
    originalMinPrice = cubit.minPriceSel;
    originalMaxPrice = cubit.maxPriceSel;
    minController.text = originalMinPrice?.toString() ?? '';
    maxController.text = originalMaxPrice?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 16.h,
          bottom: keyboardHeight + 16.h,
        ),
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
                    // Clear: Reset to null and apply filters
                    setState(() {
                      minController.clear();
                      maxController.clear();
                    });
                    context.read<StoreCubit>().updatePrice(null, null);
                    Navigator.pop(context);
                  },
                  child: const Text("Clear"),
                ),
                Text(
                  "Price",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Checkmark: Apply the price filter
                        _applyPrice();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.check, size: 20),
                    ),
                    IconButton(
                      onPressed: () {
                        // X: Discard changes and keep old filters
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close, size: 20),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Min", style: TextStyle(fontSize: 12.sp)),
                      TextField(
                        controller: minController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '0',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Max", style: TextStyle(fontSize: 12.sp)),
                      TextField(
                        controller: maxController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
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
    );
  }

  void _applyPrice() {
    final min = minController.text.isEmpty
        ? null
        : double.tryParse(minController.text);
    final max = maxController.text.isEmpty
        ? null
        : double.tryParse(maxController.text);
    context.read<StoreCubit>().updatePrice(min, max);
  }

  @override
  void dispose() {
    minController.dispose();
    maxController.dispose();
    // _applyPrice is called on explicit Confirm (check) button; keep dispose safe
    super.dispose();
  }
}
