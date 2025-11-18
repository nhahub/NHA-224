import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depi_final_project/features/store/cubit/store_cubit.dart';

class GenderBottomSheet extends StatefulWidget {
  const GenderBottomSheet({super.key});

  @override
  State<GenderBottomSheet> createState() => _GenderBottomSheetState();
}

class _GenderBottomSheetState extends State<GenderBottomSheet> {
  List<String> selectedGenders = [];

  @override
  void initState() {
    super.initState();
    selectedGenders = List.from(context.read<StoreCubit>().selectedGenders);
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
                  setState(() => selectedGenders.clear());
                  context.read<StoreCubit>().updateGenders([]);
                  Navigator.pop(context);
                },
                child: const Text("Clear"),
              ),
              const Text(
                "Gender",
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
                _buildGenderOption("Men"),
                _buildGenderOption("Women"),
                _buildGenderOption("Kids"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String option) {
    final isSelected = selectedGenders.contains(option);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedGenders.remove(option);
          } else {
            selectedGenders.add(option);
          }
        });
        // تم تحديث المنطق لتطبيق الفوري، لكن المهمة تقول apply عند tap outside أو X
        // انتظر، في المهمة "يمكن اختيار رجال ونساء معاً"، ولكن الclear يمسح الكل.
        // سأجعل التطبيق عند الضغط خارج أو X.
        // لذا، في onTap، فقط toggle، والتطبيق في على الclose.
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
              option,
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
    context.read<StoreCubit>().updateGenders(selectedGenders);
    super.dispose();
  }
}
