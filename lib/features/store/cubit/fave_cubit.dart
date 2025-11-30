import 'package:depi_final_project/data/models/product_model.dart';
import 'package:depi_final_project/data/repos/favorite_repo.dart';
import 'package:depi_final_project/features/store/cubit/fave_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaveCubit extends Cubit<FaveState>{
  FaveCubit() : super(FaveInitial());

  final fave_repo = FavoriteRepo();

  void toggleFavoriteStatus(ProductModel product) async {
    try {
      emit(FaveLoading());
      final isFavored = await fave_repo.toggleFavoriteStatus(product);
      emit(FaveToggled(product, isFavored));
    } catch (e) {
      emit(FaveError('Failed to toggle favorite status: $e'));
    }
  }

  Future<bool> isProductFavored(String productId) async{
    try{
      return await fave_repo.isProductFavored(productId);
    } catch (e) {
      emit(FaveError('Failed to check favorite status: $e'));
      return false;
    }
  }
}