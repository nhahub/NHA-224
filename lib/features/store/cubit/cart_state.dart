
import 'package:depi_final_project/data/models/cart_product.dart';
import 'package:depi_final_project/data/repos/cart_with_details.dart';

abstract class CartState {}

class CartInitial extends CartState{}

class CartLoading extends CartState{}

class CartLoaded extends CartState{
  final List<CartWithDetails> cartWithDetails;
  CartLoaded(this.cartWithDetails);
}

class CartSuccess extends CartState{}

class CartError extends CartState{
  final String message;
  CartError(this.message);
}
