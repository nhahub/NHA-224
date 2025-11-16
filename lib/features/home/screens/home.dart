import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/features/store/screens/cart.dart';
import 'package:depi_final_project/features/home/cubit/home_cubit.dart';
import 'package:depi_final_project/features/home/widgets/new_in_list.dart';
import 'package:depi_final_project/features/home/widgets/section_header.dart';
import 'package:depi_final_project/features/home/widgets/categories_list.dart';
import 'package:depi_final_project/features/home/cubit/home_cubit_states.dart';
import 'package:depi_final_project/features/home/widgets/top_selling_List.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedGender =
      'Unspecified'; // Default to show all products initially

  @override
  Widget build(BuildContext context) {
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
          return const Scaffold(
            body: SafeArea(child: Center(child: CircularProgressIndicator())),
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
                (product) => selectedGender == 'Men'
                    ? product.gender != 'Women'
                    : selectedGender == 'Women'
                    ? product.gender == 'Women'
                    : true, // Unspecified shows all
              )
              .toList();

          return Scaffold(
            body: SafeArea(
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
                    SectionHeader(title: 'Top Selling'),
                    verticalSpacing(12),
                    TopSellingList(products: filteredProducts.take(3).toList()),
                    verticalSpacing(18),
                    // New In
                    SectionHeader(
                      title: 'New In',
                      titleColor: AppColors.figmaPrimary,
                    ),
                    verticalSpacing(12),
                    TopSellingList(
                      products: filteredProducts.skip(3).take(3).toList(),
                    ),
                    
                  ],
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

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.onGenderChanged});

  final void Function(String) onGenderChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/avatar1.png'),
          radius: 22,
        ),
        _GenderSelector(onGenderChanged: onGenderChanged),
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
  String selectedValue = 'Men';

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
          color: Theme.of(context).colorScheme.surfaceVariant,
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
        const PopupMenuItem(value: 'Men', child: Text('Men')),
        const PopupMenuItem(value: 'Women', child: Text('Women')),
        const PopupMenuItem(value: 'Unspecified', child: Text('Neutral')),
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
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.search);
      },
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            hintText: 'Search',
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ),
    );
  }
}
