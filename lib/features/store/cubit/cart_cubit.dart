import 'package:depi_final_project/data/models/cart_product.dart';
import 'package:depi_final_project/data/repos/cart_repo.dart';
import 'package:depi_final_project/features/store/cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState>{
  CartCubit(): super(CartInitial());

  final CartRepo repo = CartRepo();

  void addProductToCart(CartProduct product){
    emit(CartLoading());
    try{
      repo.addToUserCart(product);
      emit(CartSuccess());
    }catch(e){
      emit(CartError(e.toString()));  
   }
  }

  void loadProducts() async{
    emit(CartLoading());
    try{
    final cartProducts = await  repo.loadCartProducts();
      emit(CartLoaded(cartProducts));
    }catch(e){
      emit(CartError(e.toString()));
    }
  }



}

