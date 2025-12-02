import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/theme/spacing.dart';
import 'package:depi_final_project/data/models/cart_product.dart';
import 'package:depi_final_project/data/models/product_model.dart';
import 'package:depi_final_project/core/services/helper_functions.dart';
import 'package:depi_final_project/features/store/cubit/fave_cubit.dart';
import 'package:depi_final_project/features/store/cubit/fave_state.dart';
import 'package:depi_final_project/features/store/cubit/cart_cubit.dart';
import 'package:depi_final_project/features/store/cubit/cart_state.dart';
import 'package:depi_final_project/core/widgets/progress_hud_widget.dart';
import 'package:depi_final_project/features/store/cubit/review_cubit.dart';
import 'package:depi_final_project/features/store/cubit/review_state.dart';


class ProductPage extends StatefulWidget {
  final ProductModel product;
  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int selectedSize = 0;
  int selectedColor = 0;
  int count = 1;
  int _currentPage = 0;
  late PageController _pageController;

  double avgRating = 0.0;
  TextEditingController _commentController = TextEditingController();
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    context.read<ReviewCubit>().loadReviews(widget.product.id);

    context
        .read<FaveCubit>()
        .isProductFavored(widget.product.id)
        .then((fav) {
          if (!mounted) return;
          setState(() {
            isFav = fav;
          });
        })
        .catchError((error) {
          // optional: handle error, e.g. log or keep default value
        });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();

    return ProgressHUDWidget(
      isLoading: context.watch<CartCubit>().state is CartLoading,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: BlocConsumer<FaveCubit, FaveState>(
                listener: (context, state) {
                  if (state is FaveToggled &&
                      state.product.id == widget.product.id) {
                    setState(() {
                      isFav = state.isFavored;
                    });
                  }
                },
                builder: (context, state) {
                  return IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav
                          ? Colors.purple
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                    onPressed: () {
                      context.read<FaveCubit>().toggleFavoriteStatus(
                        widget.product,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Carousel Section
              _buildImageCarousel(),

              // Product Info Section
              _buildProductInfo(),

              verticalSpacing(24),

              // Options Section
              _buildOptionsSection(),

              verticalSpacing(24),

              // Description Section
              _buildDescriptionSection(),

              verticalSpacing(24),

              // Shipping Info
              _buildShippingInfo(),

              verticalSpacing(32),

              // Reviews Section
              _buildReviewsSection(),

              verticalSpacing(100), // Space for FAB
            ],
          ),
        ),

        floatingActionButton: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }

            if (state is CartSuccess) {
              Navigator.pushNamed(context, '/cart');
            }
          },
          builder: (context, state) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width * 0.9,
            child: FloatingActionButton.extended(
              onPressed: () {
                cubit.addProductToCart(
                  CartProduct(
                    productId: widget.product.id,
                    selectedSize: widget.product.sizes[selectedSize],
                    selectedColor: widget.product.colors[selectedColor],
                    quantity: count,
                  ),
                );
              },
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${widget.product.price}",
                      style: GoogleFonts.gabarito(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      "Add to bag",
                      style: GoogleFonts.gabarito(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    return Column(
      children: [
        Container(
          height: 250,
          color: Theme.of(context).colorScheme.surface,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemCount: widget.product.imageUrl.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.product.imageUrl[index],
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        child: const Icon(Icons.image_not_supported, size: 50),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        verticalSpacing(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.product.imageUrl.length,
            (index) => Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? AppColors.figmaPrimary
                    : Colors.grey.withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.product.name,
                  style: GoogleFonts.gabarito(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.product.oldPrice != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${(((widget.product.oldPrice! - widget.product.price) / widget.product.oldPrice!) * 100).round()}% OFF',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          verticalSpacing(8),
          Row(
            children: [
              Text(
                '\$${widget.product.price.toStringAsFixed(2)}',
                style: GoogleFonts.gabarito(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.figmaPrimary,
                ),
              ),
              if (widget.product.oldPrice != null) ...[
                const SizedBox(width: 12),
                Text(
                  '\$${widget.product.oldPrice!.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ],
          ),
          verticalSpacing(12),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              Text(
                '${widget.product.rating.toStringAsFixed(1)} (${widget.product.stock} in stock)',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Size Selection
          if (widget.product.sizes.isNotEmpty)
            Card(
              elevation: 2,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Size',
                      style: GoogleFonts.gabarito(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    verticalSpacing(12),
                    Wrap(
                      spacing: 8,
                      children: widget.product.sizes.asMap().entries.map((
                        entry,
                      ) {
                        final index = entry.key;
                        final size = entry.value;
                        final isSelected = selectedSize == index;
                        return ChoiceChip(
                          label: Text(
                            size,
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.figmaPrimary
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() => selectedSize = index);
                            }
                          },
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.surface,
                          selectedColor: AppColors.figmaPrimary.withValues(alpha: 0.2),
                          checkmarkColor: AppColors.figmaPrimary,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

          if (widget.product.sizes.isNotEmpty &&
              widget.product.colors.isNotEmpty)
            verticalSpacing(16),

          // Color Selection
          if (widget.product.colors.isNotEmpty)
            Card(
              elevation: 2,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Color',
                      style: GoogleFonts.gabarito(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    verticalSpacing(12),
                    Wrap(
                      spacing: 8,
                      children: widget.product.colors.asMap().entries.map((
                        entry,
                      ) {
                        final index = entry.key;
                        final color = entry.value;
                        final isSelected = selectedColor == index;
                        return ChoiceChip(
                          label: Text(
                            color,
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.figmaPrimary
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() => selectedColor = index);
                            }
                          },
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.surface,
                          selectedColor: AppColors.figmaPrimary.withValues(alpha: 0.2),
                          checkmarkColor: AppColors.figmaPrimary,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

          verticalSpacing(16),

          // Quantity Selection
          Card(
            elevation: 2,
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quantity',
                    style: GoogleFonts.gabarito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: count > 1
                              ? () => setState(() => count--)
                              : null,
                          icon: const Icon(Icons.remove),
                          color: count > 1
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        Container(
                          width: 40,
                          alignment: Alignment.center,
                          child: Text(
                            count.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: count < widget.product.stock
                              ? () => setState(() => count++)
                              : null,
                          icon: const Icon(Icons.add),
                          color: count < widget.product.stock
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: GoogleFonts.gabarito(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              verticalSpacing(12),
              Text(
                widget.product.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShippingInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shipping & Returns',
                style: GoogleFonts.gabarito(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              verticalSpacing(12),
              Row(
                children: [
                  Icon(
                    Icons.local_shipping_outlined,
                    color: AppColors.figmaPrimary,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Free standard shipping on orders over \$50',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpacing(8),
              Row(
                children: [
                  Icon(Icons.refresh, color: AppColors.figmaPrimary, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Free 60-day returns',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reviews & Ratings',
                style: GoogleFonts.gabarito(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Show add review modal
                  _showAddReviewModal();
                },
                child: Text(
                  'Write Review',
                  style: TextStyle(
                    color: AppColors.figmaPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          verticalSpacing(16),
          Card(
            elevation: 2,
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        widget.product.rating.toStringAsFixed(1),
                        style: GoogleFonts.gabarito(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.figmaPrimary,
                        ),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < widget.product.rating.floor()
                                ? Icons.star
                                : index < widget.product.rating
                                ? Icons.star_half
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: BlocBuilder<ReviewCubit, ReviewState>(
                      builder: (context, state) {
                        final reviewCount = state is ReviewsLoaded
                            ? state.reviews.length
                            : 0;
                        return Text(
                          '$reviewCount reviews',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          verticalSpacing(16),
          BlocBuilder<ReviewCubit, ReviewState>(
            builder: (context, state) {
              if (state is ReviewLoading) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state is ReviewsLoaded) {
                final reviews = state.reviews;
                if (reviews.isEmpty) {
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Center(
                        child: Text(
                          'No reviews yet. Be the first to review this product!',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: reviews.length > 3 ? 3 : reviews.length,
                  itemBuilder: (context, index) {
                    final review = reviews[index];
                    final currentUserId = context.read<ReviewCubit>().getCurrentUserId();
                    final isCurrentUser = review.userId == currentUserId;

                    // For current user's review, show "me" and get current profile image
                    final displayName = isCurrentUser ? "me" : review.reviewerName;

                    return Card(
                      elevation: 1,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                isCurrentUser
                                    ? FutureBuilder<String>(
                                        future: context.read<ReviewCubit>().getCurrentUserImage(),
                                        builder: (context, snapshot) {
                                          final imageUrl = snapshot.data ?? "";
                                          return CircleAvatar(
                                            backgroundImage: imageUrl.isNotEmpty
                                                ? NetworkImage(imageUrl)
                                                : null,
                                            child: imageUrl.isEmpty
                                                ? Text(displayName[0].toUpperCase())
                                                : null,
                                          );
                                        },
                                      )
                                    : CircleAvatar(
                                        backgroundImage: review.userImage.isNotEmpty
                                            ? NetworkImage(review.userImage)
                                            : null,
                                        child: review.userImage.isEmpty
                                            ? Text(displayName[0].toUpperCase())
                                            : null,
                                      ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        displayName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).colorScheme.onSurface,
                                        ),
                                      ),
                                      Text(
                                        HelperFunctions.timeAgoFromDate(
                                          review.timeAgo,
                                        ),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: List.generate(5, (starIndex) {
                                    return Icon(
                                      starIndex < review.rating
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.amber,
                                      size: 14,
                                    );
                                  }),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              review.comment,
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  void _showAddReviewModal() {
    double modalRating = avgRating; // Local rating for the modal

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Write a Review',
                style: GoogleFonts.gabarito(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              verticalSpacing(20),
              Text(
                'Rating',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              verticalSpacing(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setModalState(() => modalRating = index + 1.0);
                        },
                        child: Icon(
                          index < modalRating ? Icons.star : Icons.star_border,
                          color: index < modalRating ? Colors.amber : Colors.grey.shade300,
                          size: 32,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${modalRating.toStringAsFixed(1)} stars',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              verticalSpacing(20),
              Text(
                'Your Review',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              verticalSpacing(8),
              TextField(
                controller: _commentController,
                maxLines: 4,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                  hintText: 'Share your thoughts about this product...',
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                ),
              ),
              verticalSpacing(20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (modalRating > 0 &&
                        _commentController.text.trim().isNotEmpty) {
                      // Update the parent state with the modal rating
                      setState(() => avgRating = modalRating);

                      context.read<ReviewCubit>().addToFirestore(
                        productId: widget.product.id,
                        rating: modalRating,
                        comment: _commentController.text.trim(),
                      );
                      Navigator.pop(context);
                      _commentController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Review submitted successfully!',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.figmaPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit Review',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
