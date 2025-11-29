import 'package:depi_final_project/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

class FaveState extends Equatable{
  @override
  List<Object?> get props => [];
}
  
  class FaveInitial extends FaveState{}

  class FaveLoading extends FaveState{}

  class FaveLoaded extends FaveState{
    final List<ProductModel> favoriteProducts;

  FaveLoaded(this.favoriteProducts);

  @override
  List<Object?> get props => [favoriteProducts];
  }

class FaveToggled extends FaveState {
  final ProductModel product;
  final bool isFavored;

  FaveToggled(this.product, this.isFavored);

  @override
  List<Object?> get props => [product, isFavored];
}
  class FaveError extends FaveState {
  final String message;

  FaveError(this.message);

  @override
  List<Object?> get props => [message];
}

