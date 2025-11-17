import 'package:flutter/material.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:depi_final_project/core/widgets/app_bar_widget.dart';
import 'package:depi_final_project/features/store/screens/cart.dart';
import 'package:depi_final_project/features/home/widgets/new_in_list.dart';
import 'package:depi_final_project/features/home/widgets/categories_list.dart';
import 'package:depi_final_project/features/store/widgets/section_header.dart';
import 'package:depi_final_project/features/home/widgets/top_selling_List.dart';
import 'package:depi_final_project/features/personalization/ui/screens/settings_screen_english.dart';
// import 'package:depi_final_project/features/store/screens/search_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? selectedValue;

  final List<Map<String, String>> categories = [
    {'image': 'assets/images/Ellipse 5 (3).png', 'label': 'Hoodies'},
    {'image': 'assets/images/Ellipse 5 (3).png', 'label': 'Shorts'},
    {'image': 'assets/images/Ellipse 5 (3).png', 'label': 'Shoes'},
    {'image': 'assets/images/Ellipse 5 (3).png', 'label': 'Bag'},
    {'image': 'assets/images/Ellipse 5 (3).png', 'label': 'Accessories'},
  ];

  final List<Map<String, String>> topSelling = [
    {
      'image': 'assets/images/Rectangle 8.png',
      'title': "Men's Harrington Jacket",
      'price': '\$148.00',
    },
    {
      'image': 'assets/images/Rectangle 8.png',
      'title': "Max Cirro Men's Slides",
      'price': '\$55.00',
      'oldPrice': '\$100.97',
    },
    {
      'image': 'assets/images/Rectangle 8.png',
      'title': "Men's Tech Pants",
      'price': '\$66.00',
    },
  ];

  final List<Map<String, String>> newIn = [
    {
      'image': 'assets/images/Rectangle 8.png',
      'title': "Men's T-shirt",
      'price': '\$35.00',
    },
    {
      'image': 'assets/images/Rectangle 8.png',
      'title': "Running Sneakers",
      'price': '\$80.00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Home',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar1.png'),
                    radius: 25,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.darkSecondary,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: DropdownButton<String>(
                          value: selectedValue,
                          hint: Text(
                            'Select Gender',
                            style: AppTextStyles.font17WiteRegular.copyWith(
                              fontSize: 16.sp,
                            ),
                          ),
                          isExpanded: true,
                          underline: const SizedBox(),
                          items: const [
                            DropdownMenuItem(
                              value: 'Male',
                              child: Text('Male'),
                            ),
                            DropdownMenuItem(
                              value: 'Female',
                              child: Text('Female'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(FontAwesomeIcons.cartFlatbed),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Cart()),
                      );
                    },
                  ),
                ],
              ),

              verticalSpacing(24),

              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.search);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.darkSecondary,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    enabled: false, // عشان ما يفتحش الكيبورد
                    style: AppTextStyles.font17WiteRegular.copyWith(
                      fontSize: 16.sp,
                    ),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.search, color: Colors.white54),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              verticalSpacing(24),

              SectionHeader(
                title: 'Categories',
                onSeeAllTap: () =>
                    Navigator.pushNamed(context, AppRoutes.shopByCategory),
              ),
              verticalSpacing(16),
              CategoriesList(categories: categories),

              verticalSpacing(24),

              SectionHeader(title: 'Top Selling'),
              verticalSpacing(16),
              TopSellingList(topSelling: topSelling),

              verticalSpacing(24),
              SectionHeader(title: 'New In', titleColor: AppColors.darkPrimary),
              verticalSpacing(16),
              NewInList(newIn: newIn),
            ],
          ),
        ),
      ),
    );
  }
}
