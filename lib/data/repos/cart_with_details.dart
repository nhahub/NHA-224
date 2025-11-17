import 'package:depi_final_project/data/models/cart_product.dart';
import 'package:depi_final_project/data/models/product_model.dart';

class CartWithDetails {

  final ProductModel product;
  final CartProduct cartDetails;

  CartWithDetails({
    required this.product,
    required this.cartDetails
  });

}