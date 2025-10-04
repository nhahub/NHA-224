import 'package:depi_final_project/features/store/widgets/header_bottom_sheat.dart';
import 'package:depi_final_project/features/store/widgets/select_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBottomSheet extends StatefulWidget {
  final String title;
  final List<String> options;

  const FilterBottomSheet({
    super.key,
    required this.title,
    required this.options,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 844.h,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderBottomSheet(
            text: widget.title,
            onTap: () {
              //cleare option
            },
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: widget.options.length,
              itemBuilder: (context, index) {
                final option = widget.options[index];
                final isSelected = selectedOption == option;

                return GestureDetector(
                  onTap: () {
                    setState(() => selectedOption = option);
                    // Navigator.pop(context, option);
                  },
                  child: SelectFiled(isSelected: isSelected, option: option),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
