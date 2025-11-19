
import 'package:depi_final_project/data/models/cart_product.dart';
import 'package:depi_final_project/data/repos/cart_with_details.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CartInitial extends CartState{}

class CartLoading extends CartState{}

class CartLoaded extends CartState{
  final List<CartWithDetails> cartWithDetails;
  CartLoaded(this.cartWithDetails);
}

class CartSuccess extends CartState{}

class RemoveAllSuccess extends CartState{}

class CartError extends CartState{
  final String message;
  CartError(this.message);
}
