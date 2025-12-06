import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depi_final_project/data/repos/cart_repo.dart';
import 'package:depi_final_project/data/models/cart_product.dart';
import 'package:depi_final_project/features/store/cubit/cart_state.dart';

class CartCubit extends Cubit<CartState>{
  CartCubit(): super(CartInitial());

  final CartRepo repo = CartRepo();

  Future<void> addProductToCart(CartProduct product) async {
    emit(CartLoading());
    try {
      await repo.addToUserCart(product);
      await loadProducts(); // Update immediately
      emit(CartSuccess());
    } catch(e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> loadProducts() async{
    emit(CartLoading());
    try{
    final cartProducts = await  repo.loadCartProducts();
      emit(CartLoaded(cartProducts));
    }catch(e){
      emit(CartError(e.toString()));
    }
  }


  Future<void> removeAllCartProducts()async{
    emit(CartLoading());
    try{
      await repo.removeAllCartProduct();
      emit(RemoveAllSuccess());
    }catch(e){
      emit(CartError(e.toString()));
    }
  }


Future<void> editProductQuantity(String productId, String size, String color, int quantity) async{
  emit(CartLoading());
  try{
    await repo.editCartItemQuantity(productId, size, color, quantity);
    final cartProducts = await repo.loadCartProducts();
    emit(CartLoaded(cartProducts));
  }catch(e){
    emit(CartError(e.toString()));
  }
}

Future<void> deleteProduct(String productId, String size, String color)async{
  emit(CartLoading());
  try{
    await repo.deleteCartItem(productId, size, color);
    final cartProducts = await repo.loadCartProducts();
    emit(CartLoaded(cartProducts));
  }catch(e){
    emit(CartError(e.toString()));
  }
}
}
