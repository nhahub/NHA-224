import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/features/store/widgets/shop_by_cat.dart';
import 'package:depi_final_project/features/store/widgets/filter_bottom.dart';
import 'package:depi_final_project/features/store/widgets/search_widget.dart';
import 'package:depi_final_project/features/store/widgets/filter_bottom_sheat.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const SearchWidget(),
            const SizedBox(height: 16),
            Row(
              children: [
                FilterButton(
                  title: "Price",
                  icon: Icons.attach_money,

                  onTap: () => showModalBottomSheet(
                    context: context,
                    // isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const FilterBottomSheet(
                      title: "Price",
                      options: [
                        "Min",
                        "Max",
                        // "Above 1000",
                      ],
                    ),
                  ),
                ),
                FilterButton(
                  title: "Gender",
                  icon: Icons.person,

                  onTap: () => showModalBottomSheet(
                    context: context,
                    // isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const FilterBottomSheet(
                      title: "Gender",
                      options: ["Men", "Women", "Kids"],
                    ),
                  ),
                ),
                FilterButton(
                  title: "Sort by",
                  icon: Icons.sort,
                  onTap: () => showModalBottomSheet(
                    context: context,
                    // isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const FilterBottomSheet(
                      title: "Sort",
                      options: ["Newest", "Oldest"],
                    ),
                  ),
                ),
              ],
            ),
            // EmpityWidgets(),
            ShopByCatWidget(),
          ],
        ),
      ),
    );
  }
}
