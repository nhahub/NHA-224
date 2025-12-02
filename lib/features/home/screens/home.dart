import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/features/store/screens/cart.dart';
import 'package:depi_final_project/core/widgets/product_skeleton.dart';
import 'package:depi_final_project/features/home/cubit/home_cubit.dart';
import 'package:depi_final_project/features/home/widgets/new_in_list.dart';
import 'package:depi_final_project/features/home/widgets/section_header.dart';
import 'package:depi_final_project/features/home/widgets/categories_list.dart';
import 'package:depi_final_project/features/home/cubit/home_cubit_states.dart';
import 'package:depi_final_project/features/home/widgets/top_selling_List.dart';
import 'package:depi_final_project/core/services/shared_preferences_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedGender =
      'All'; // Default to show all products initially

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context).colorScheme;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is HomeLoading || state is HomeInitial) {
          context.read<HomeCubit>().loadHome();
          return Scaffold(
            body: SafeArea(
              child: Skeletonizer(
                enabled: true,
                effect: ShimmerEffect(
                  highlightColor: isDarkTheme
                      ? Colors.grey.shade700
                      : Colors.white,
                  baseColor: isDarkTheme
                      ? Colors.grey.shade800
                      : Colors.grey.shade300,
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Header - profile, gender selector, cart button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: isDarkTheme
                                ? theme.secondary.withOpacity(0.8)
                                : theme.secondary,
                          ),
                          Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: theme.secondary,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Men',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.transparent,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 16,
                                  color: Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: AppColors.figmaPrimary.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(
                              Icons.shopping_bag,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      verticalSpacing(18),

                      // Search bar
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: theme.secondary.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            Icon(
                              Icons.search,
                              color: theme.secondary.withOpacity(0.7),
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Search',
                              style: TextStyle(
                                color: theme.secondary.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      verticalSpacing(18),

                      // Categories Section
                      SectionHeaderSkeleton(),
                      verticalSpacing(12),
                      // Categories Horizontal List
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) => Container(
                            width: 80,
                            margin: const EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              color: theme.secondary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: theme.secondary.withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 12,
                                  width: 50,
                                  color: theme.secondary.withOpacity(0.7),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Top Selling Section
                      verticalSpacing(24),
                      SectionHeaderSkeleton(
                        titleWidth: MediaQuery.of(context).size.width * 0.35,
                      ),
                      verticalSpacing(12),
                      const ProductSkeleton(itemCount: 6),
                      verticalSpacing(24),

                      // New In Section
                      SectionHeaderSkeleton(
                        titleWidth: MediaQuery.of(context).size.width * 0.25,
                        titleColor: AppColors.figmaPrimary.withOpacity(0.7),
                      ),
                      verticalSpacing(12),
                      const ProductSkeleton(itemCount: 6),

                      // Extra bottom space
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        if (state is HomeError) {
          return const Scaffold(
            body: SafeArea(child: Center(child: Text('Error loading home'))),
          );
        }

        if (state is HomeLoaded) {
          // Simple filtering by gender - in a real app, this might be server-side
          final filteredProducts = state.products
              .where(
                (product) => selectedGender == 'All'
                    ? true // Show all products
                    : selectedGender == 'Men'
                    ? product.gender == 'Men'
                    : selectedGender == 'Women'
                    ? product.gender == 'Women'
                    : false, // Should not happen with current options
              )
              .toList();

          return Scaffold(
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<HomeCubit>().loadHome();
                },
                color: AppColors.figmaPrimary,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Custom header row
                      _HomeHeader(
                        onGenderChanged: (gender) {
                          setState(() {
                            selectedGender = gender;
                          });
                        },
                      ),
                      verticalSpacing(18),
                      // Search bar
                      const _SearchBar(),
                      verticalSpacing(18),
                      // Categories
                      SectionHeader(
                        title: 'Categories',
                        onSeeAllTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.shopByCategory,
                        ),
                      ),
                      verticalSpacing(12),
                      CategoriesList(categories: state.categories),

                      // Top Selling
                      SectionHeader(
                        title: 'Top Selling',
                        onSeeAllTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.allTopSelling,
                        ),
                      ),
                      verticalSpacing(12),
                      TopSellingList(
                        products: filteredProducts.take(3).toList(),
                      ),
                      verticalSpacing(18),
                      // New In
                      SectionHeader(
                        title: 'New In',
                        titleColor: AppColors.figmaPrimary,
                        onSeeAllTap: () =>
                            Navigator.pushNamed(context, AppRoutes.allNewIn),
                      ),
                      verticalSpacing(12),
                      TopSellingList(
                        products: filteredProducts.skip(3).take(3).toList(),
                      ),
                      // Add bottom padding for better UX
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return const Scaffold(
          body: SafeArea(child: Center(child: Text('Unknown state'))),
        );
      },
    );
  }
}

class _HomeHeader extends StatefulWidget {
  const _HomeHeader({required this.onGenderChanged});

  final void Function(String) onGenderChanged;

  @override
  State<_HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<_HomeHeader> {
  final SharedPreferencesService _prefs = SharedPreferencesService();

  @override
  Widget build(BuildContext context) {
    final profileImageUrl = _prefs.profileImageUrl;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.profile);
          },
          child: CircleAvatar(
            backgroundImage: profileImageUrl.isNotEmpty
                ? NetworkImage(profileImageUrl)
                : NetworkImage(
                    "https://imgs.search.brave.com/r8_rpLtbGMxU9_hP_eV66IWtpYYaUuj62TaONvbGyA8/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly91cy4x/MjNyZi5jb20vNDUw/d20vYmxpbmtibGlu/azEvYmxpbmtibGlu/azEyMDA1L2JsaW5r/YmxpbmsxMjAwNTAw/MDE1LzE0Njk3OTQ2/NC1hdmF0YXItbWFu/bi1zeW1ib2wuanBn/P3Zlcj02",
                  ),
            radius: 22,
            onBackgroundImageError: (exception, stackTrace) {
              // Fallback to asset image if network image fails
            },
          ),
        ),
        _GenderSelector(onGenderChanged: widget.onGenderChanged),
        const _CartButton(),
      ],
    );
  }
}

class _GenderSelector extends StatefulWidget {
  const _GenderSelector({required this.onGenderChanged});

  final void Function(String) onGenderChanged;

  @override
  State<_GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<_GenderSelector> {
  String selectedValue = 'All';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showGenderPopupMenu(context);
      },
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedValue,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  void _showGenderPopupMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        button.localToGlobal(Offset.zero, ancestor: overlay).dx,
        button.localToGlobal(Offset.zero, ancestor: overlay).dy,
        overlay.size.width -
            button
                .localToGlobal(
                  button.size.bottomRight(Offset.zero),
                  ancestor: overlay,
                )
                .dx,
        overlay.size.height -
            button
                .localToGlobal(
                  button.size.bottomRight(Offset.zero),
                  ancestor: overlay,
                )
                .dy,
      ),
      items: [
        const PopupMenuItem(value: 'All', child: Text('All')),
        const PopupMenuItem(value: 'Women', child: Text('Women')),
        const PopupMenuItem(value: 'Men', child: Text('Men')),
      ],
    );

    if (result != null && result != selectedValue) {
      setState(() {
        selectedValue = result;
      });
      widget.onGenderChanged(result);
    }
  }
}

class _CartButton extends StatelessWidget {
  const _CartButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Cart()),
        );
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: AppColors.figmaPrimary,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Icon(Icons.shopping_bag, color: Colors.white),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          // Navigate immediately to Search page on tap
          Navigator.pushNamed(context, AppRoutes.search);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 12),
              Text(
                'Search products',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeaderSkeleton extends StatelessWidget {
  final double? titleWidth;
  final Color? titleColor;

  const SectionHeaderSkeleton({super.key, this.titleWidth, this.titleColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 24,
          width: titleWidth ?? MediaQuery.of(context).size.width * 0.25,
          color: titleColor ?? theme.secondary,
        ),
        Container(
          height: 16,
          width: MediaQuery.of(context).size.width * 0.15,
          color: theme.secondary.withOpacity(0.7),
        ),
      ],
    );
  }
}
