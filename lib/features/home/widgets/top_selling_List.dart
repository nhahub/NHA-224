import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depi_final_project/data/models/product_model.dart';
import 'package:depi_final_project/features/store/cubit/fave_cubit.dart';
import 'package:depi_final_project/features/store/cubit/fave_state.dart';
import 'package:depi_final_project/features/store/screens/product_page.dart';
import 'package:depi_final_project/features/home/widgets/product_widget.dart';

class TopSellingList extends StatelessWidget {
  const TopSellingList({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return SizedBox(
            width: 180,
            child: _FavouriteProductItem(product: product),
          );
        },
      ),
    );
  }
}

class _FavouriteProductItem extends StatefulWidget {
  const _FavouriteProductItem({required this.product});

  final ProductModel product;

  @override
  State<_FavouriteProductItem> createState() => _FavouriteProductItemState();
}

class _FavouriteProductItemState extends State<_FavouriteProductItem> {
  late bool isFav;

  @override
  void initState() {
    super.initState();
    isFav = false;
    _loadFavouriteStatus();
  }

  Future<void> _loadFavouriteStatus() async {
    try {
      final fav = await context.read<FaveCubit>().isProductFavored(widget.product.id);
      if (mounted) {
        setState(() => isFav = fav);
      }
    } catch (e) {
      // Handle error, keep default false
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FaveCubit, FaveState>(
      listener: (context, state) {
        if (state is FaveToggled && state.product.id == widget.product.id) {
          setState(() => isFav = state.isFavored);
        }
      },
      child: ProductWidget(
        image: widget.product.imageUrl.isNotEmpty ? widget.product.imageUrl[0] : '',
        title: widget.product.name,
        price: '\$${widget.product.price.toStringAsFixed(2)}',
        oldPrice: widget.product.oldPrice != null
            ? '\$${widget.product.oldPrice!.toStringAsFixed(2)}'
            : null,
        isFavorite: isFav,
        onFavoritePressed: () {
          context.read<FaveCubit>().toggleFavoriteStatus(widget.product);
        },
        onTap: () {
          // Navigate to product details
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductPage(product: widget.product)),
          );
        },
      ),
    );
  }
}
