import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';
import 'package:depi_final_project/shared/spacing.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          border: Border.all(color: AppColors.darkSecondary),
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
                            DropdownMenuItem(value: 'Men', child: Text('Men')),
                            DropdownMenuItem(
                              value: 'Women',
                              child: Text('Women'),
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
                      // Handle menu button press
                    },
                  ),
                ],
              ),
              verticalSpacing(24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.darkSecondary,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  style: AppTextStyles.font17WiteRegular.copyWith(
                    fontSize: 16.sp,
                  ),
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.white54),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 🧢 Categories Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Categories',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Categories List
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategory('assets/hoodie.png', 'Hoodies'),
                    _buildCategory('assets/shorts.png', 'Shorts'),
                    _buildCategory('assets/shoes.png', 'Shoes'),
                    _buildCategory('assets/bag.png', 'Bag'),
                    _buildCategory('assets/accessories.png', 'Accessories'),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 🛍️ Top Selling Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Top Selling',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Top Selling Products
              SizedBox(
                height: 260,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildProductCard(
                      image: 'assets/images/Rectanglثe 8.png',
                      title: "Men's Harrington Jacket",
                      price: '\$148.00',
                    ),
                    _buildProductCard(
                      image: 'assets/images/Rectangle 8.png',
                      title: "Max Cirro Men's Slides",
                      price: '\$55.00',
                      oldPrice: '\$100.97',
                    ),
                    _buildProductCard(
                      image: 'assets/images/Rectangle 8.png',
                      title: "Men's Tech Pants",
                      price: '\$66.00',
                    ),
                  ],
                ),
              ),
              verticalSpacing(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'New In',
                    style: TextStyle(
                      color: Color(0xFF9B6BFF),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // New In List
              SizedBox(
                height: 281,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildProductCard(
                      image: 'assets/images/Rectangle 8.png',
                      title: "Men's T-shirt",
                      price: '\$35.00',
                    ),
                    _buildProductCard(
                      image: 'assets/images/Rectangle 8.png',
                      title: "Running Sneakers",
                      price: '\$80.00',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildCategory(String image, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: const Color(0xFF1E1A2E),
            backgroundImage: AssetImage(image),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  static Widget _buildProductCard({
    required String image,
    required String title,
    required String price,
    String? oldPrice,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        width: 159,
        height: 281,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1A2E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.asset(
                image,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  if (oldPrice != null) ...[
                    const SizedBox(width: 8),
                    Text(
                      oldPrice,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 13,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
