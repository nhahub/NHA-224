import 'package:depi_final_project/core/errors/failures.dart';
import 'package:depi_final_project/core/services/helper_functions.dart';
import 'package:depi_final_project/data/models/review_model.dart';
import 'package:depi_final_project/data/repos/review_repo.dart';
import 'package:depi_final_project/features/store/cubit/fave_cubit.dart';
import 'package:depi_final_project/features/store/cubit/fave_state.dart';
import 'package:depi_final_project/features/store/cubit/review_cubit.dart';
import 'package:depi_final_project/features/store/cubit/review_state.dart';
import 'package:depi_final_project/features/store/widgets/report_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/data/models/cart_product.dart';
import 'package:depi_final_project/data/models/product_model.dart';
import 'package:depi_final_project/data/models/product_model.dart';
import 'package:depi_final_project/features/store/cubit/cart_cubit.dart';
import 'package:depi_final_project/features/store/cubit/cart_state.dart';
import 'package:depi_final_project/core/widgets/progress_hud_widget.dart';
import 'package:depi_final_project/features/store/widgets/counter_btn.dart';
import 'package:depi_final_project/features/store/widgets/review_card.dart';
import 'package:depi_final_project/features/store/widgets/app_bar_icon.dart';
import 'package:depi_final_project/features/store/widgets/product_option.dart';
import 'package:depi_final_project/features/store/widgets/customize_option.dart';
import 'package:depi_final_project/features/store/widgets/custom_bottom_sheet.dart';

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

  double avgRating = 0.0;
  TextEditingController _commentController = TextEditingController();
  TextEditingController _editCommentController = TextEditingController();
  bool isFav = false;

  @override
  void initState() {
    super.initState();

    context.read<ReviewCubit>().loadReviews(widget.product.id);

  
    context
      .read<FaveCubit>()
      .isProductFavored(widget.product.id)
      .then((fav) {
      if (!mounted) return;
      setState(() {
      isFav = fav;
      });
    }).catchError((error) {
      // optional: handle error, e.g. log or keep default value
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeBrightness = Theme.of(context).brightness;

    final cubit = context.read<CartCubit>();

    return ProgressHUDWidget(
      isLoading: context.watch<CartCubit>().state is CartLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: AppBarIcon(
              icon: themeBrightness == Brightness.light
                  ? "assets/icons/arrowleft.png"
                  : "assets/icons/arrowleft_dark.png",
              onTap: () => Navigator.pop(context),
            ),
          ),

          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 10),
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
                      color: isFav ? Colors.red : AppColors.black,
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

        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.product.imageUrl.length,
                    itemBuilder: (context, index) {
                      return Image.network(widget.product.imageUrl[index]);
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    widget.product.name,
                    style: GoogleFonts.gabarito(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "\$${widget.product.price}",
                  style: GoogleFonts.gabarito(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff8E6CEF),
                    ),
                  ),
                ),

                ProductOption(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return CustomBottomSheet(
                          title: "Size",
                          options: List.generate(widget.product.sizes.length, (
                            index,
                          ) {
                            return CustomizeOption(
                              label: widget.product.sizes[index],
                              isSelected: selectedSize == index,
                              onTap: () {
                                setState(() {
                                  selectedSize = index;
                                  Navigator.pop(context);
                                });
                              },
                            );
                          }),
                        );
                      },
                    );
                  },
                  label: "Size",
                  options: [
                    Text(
                      widget.product.sizes[selectedSize],
                      style: GoogleFonts.gabarito(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    Image.asset(
                      themeBrightness == Brightness.light
                          ? "assets/icons/arrowdown.png"
                          : "assets/icons/arrowdown_dark.png",
                    ),
                  ],
                ),
                ProductOption(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return CustomBottomSheet(
                          title: "Color",
                          options: List.generate(widget.product.colors.length, (
                            index,
                          ) {
                            return CustomizeOption(
                              label: widget.product.colors[index],
                              isSelected: selectedColor == index,
                              onTap: () {
                                setState(() {
                                  selectedColor = index;
                                  Navigator.pop(context);
                                });
                              },
                              selection: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  // color: Color(int.parse(widget.product.colors[index]))
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    );
                  },
                  label: "Color",
                  options: [
                    Text(widget.product.colors[selectedColor]),
                    SizedBox(width: 30),
                    Image.asset(
                      themeBrightness == Brightness.light
                          ? "assets/icons/arrowdown.png"
                          : "assets/icons/arrowdown_dark.png",
                    ),
                  ],
                ),
                ProductOption(
                  label: "Quantity",
                  options: [
                    CounterBtn(
                      onTap: () {
                        setState(() {
                          if (count < widget.product.stock) count++;
                        });
                      },
                      icon: "+",
                    ),
                    SizedBox(width: 20),

                    Text("$count", style: TextStyle(fontSize: 16)),
                    SizedBox(width: 20),
                    CounterBtn(
                      onTap: () {
                        setState(() {
                          if (count > 1) count--;
                        });
                      },
                      icon: "--",
                    ),
                  ],
                ),

                //TODO: get all values from database
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.product.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(176, 119, 119, 119),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Shipping & Returns",
                  style: GoogleFonts.gabarito(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Free standard shipping and free 60-day returns",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(176, 119, 119, 119),
                  ),
                ),

                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) => Container(
                            padding: EdgeInsets.all(20),
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                              color: AppColors.lightBorder,
                            ),
                            child: BlocConsumer<ReviewCubit, ReviewState>(
                              listener: (context, state) {
                                if (state is ReviewSuccess) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Your review added successfully",
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                return state is ReviewLoading
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.darkPrimary,
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          SizedBox(height: 10),
                                          Text(
                                            "How do you see this product",
                                            style: GoogleFonts.gabarito(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              StarRating(
                                                rating: avgRating,
                                                color: AppColors.darkPrimary,
                                                allowHalfRating: true,
                                                onRatingChanged: (rating) {
                                                  setState(() {
                                                    avgRating = rating;
                                                  });
                                                },
                                              ),
                                              SizedBox(width: 5),
                                              Text("$avgRating"),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          TextField(
                                            controller: _commentController,
                                            maxLines: 7,
                                            decoration: InputDecoration(
                                              hintText:
                                                  "Type your comment here",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Align(
                                            alignment:
                                                AlignmentGeometry.centerRight,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                final cubit = context
                                                    .read<ReviewCubit>();
                                                cubit.addToFirestore(
                                                  productId: widget.product.id,
                                                  rating: avgRating,
                                                  comment:
                                                      _commentController.text,
                                                );
                                                setState(() {});
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text("Comment"),
                                                  SizedBox(width: 10),
                                                  Icon(
                                                    Icons.arrow_circle_up,
                                                    size: 25,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkPrimary,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Write your Review",
                        style: GoogleFonts.gabarito(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.star),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Reviews",
                  style: GoogleFonts.gabarito(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "${widget.product.rating} Rating",
                  style: GoogleFonts.gabarito(
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BlocBuilder<ReviewCubit, ReviewState>(
                  builder: (context, state) {
                    if (state is ReviewLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.darkPrimary,
                        ),
                      );
                    }

                    if (state is ReviewsLoaded) {
                      final reviews = state.reviews;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            "${reviews.length} reviews",
                            style: TextStyle(
                              color: Color.fromARGB(176, 119, 119, 119),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: ListView.builder(
                              itemCount: reviews.length,
                              itemBuilder: (context, i) {
                                return ReviewCard(
                                  avatar: reviews[i].userImage,
                                  name: reviews[i].reviewerName,
                                  review: reviews[i].comment,
                                  daysAgo: HelperFunctions.timeAgoFromDate(
                                    reviews[i].timeAgo,
                                  ),
                                  rating: reviews[i].rating,
                                  isUserReview: context
                                      .read<ReviewCubit>()
                                      .isUserReview(reviews[i].userId!),
                                  onReportPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        Map<String, bool> reportReasons = {};
                                        return AlertDialog(
                                          title: Text("Report this review"),
                                          content: ReportWidget(
                                            onChanged: (map) {
                                              reportReasons = map;
                                            },
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                context
                                                    .read<ReviewCubit>()
                                                    .submitReport(
                                                      widget.product.id,
                                                      reviews[i].userId!,
                                                      reportReasons,
                                                    );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.darkPrimary,
                                                foregroundColor: Colors.white,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "Submit Report",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Icon(
                                                    Icons.flag_outlined,
                                                    color: Colors.white,
                                                    size: 25,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  onMorePressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        _editCommentController.text =
                                            reviews[i].comment;
                                        double tempRating = reviews[i].rating;
                                        return StatefulBuilder(
                                          builder: (context, setState) => Container(
                                            padding: EdgeInsets.all(20),
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.5,
                                            child: Column(
                                              children: [
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                              "Delete review",
                                                            ),
                                                            content: Text(
                                                              "Are you sure you want to delete your review",
                                                            ),
                                                            actions: [
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  context
                                                                      .read<
                                                                        ReviewCubit
                                                                      >()
                                                                      .deleteReview(
                                                                        widget
                                                                            .product
                                                                            .id,
                                                                      );
                                                                  Navigator.pop(
                                                                    context,
                                                                  ); // Close the dialog
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  foregroundColor:
                                                                      Colors
                                                                          .white,
                                                                ),
                                                                child: Text(
                                                                  "Yes delete my review",
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                    context,
                                                                  );
                                                                  Navigator.pop(
                                                                    context,
                                                                  );
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .darkPrimary,
                                                                  foregroundColor:
                                                                      Colors
                                                                          .white,
                                                                ),
                                                                child: Text(
                                                                  "No",
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "Edit your review",
                                                  style: GoogleFonts.gabarito(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24,
                                                  ),
                                                ),

                                                SizedBox(height: 20),
                                                StarRating(
                                                  rating: tempRating,
                                                  color: AppColors.darkPrimary,
                                                  allowHalfRating: true,
                                                  onRatingChanged: (rating) {
                                                    setState(() {
                                                      tempRating = rating;
                                                    });
                                                  },
                                                ),
                                                SizedBox(height: 20),
                                                TextField(
                                                  controller:
                                                      _editCommentController,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Type your comment here",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                  ),
                                                  maxLines: 7,
                                                ),
                                                SizedBox(height: 20),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    final cubit = context
                                                        .read<ReviewCubit>();
                                                    cubit.editReview(
                                                      productId:
                                                          widget.product.id,
                                                      username: reviews[i]
                                                          .reviewerName,
                                                      userImage:
                                                          reviews[i].userImage,
                                                      userId:
                                                          reviews[i].userId!,
                                                      rating: tempRating,
                                                      comment:
                                                          _editCommentController
                                                              .text
                                                              .isNotEmpty
                                                          ? _editCommentController
                                                                .text
                                                          : reviews[i].comment,
                                                    );
                                                    cubit.loadReviews(
                                                      widget.product.id,
                                                    );
                                                    setState(() {
                                                      avgRating =
                                                          widget.product.rating;
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            AppColors
                                                                .darkPrimary,
                                                        foregroundColor:
                                                            Colors.white,
                                                      ),
                                                  child: Text(
                                                    "Save Changes",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 200),
                        ],
                      );
                    }
                    if (state is ReviewError) {
                      return Center(child: Text(state.message));
                    }
                    return Center(child: Text("your review is added"));
                  },
                ),
              ],
            ),
          ),
        ),

        floatingActionButton: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }

            if (state is CartSuccess) {
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product added successfully", style: TextStyle(color: Colors.white),), backgroundColor: Colors.green,));
              Navigator.pushNamed(context, AppRoutes.cart);
            }
          },
          builder: (context, state) => Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
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
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${widget.product.price}",
                      style: GoogleFonts.gabarito(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      "Add to bag",
                      style: GoogleFonts.gabarito(
                        textStyle: TextStyle(fontSize: 16, color: Colors.white),
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
}
