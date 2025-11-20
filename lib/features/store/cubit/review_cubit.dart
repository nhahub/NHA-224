import 'package:depi_final_project/data/models/review_model.dart';
import 'package:depi_final_project/data/repos/review_service.dart';
import 'package:depi_final_project/features/store/cubit/review_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewCubit extends Cubit<ReviewState>{

  ReviewCubit(): super(ReviewInitial());

  final ReviewService _service = ReviewService();
  void addToFirestore({required String productId,required double rating , required String comment}){
    emit(ReviewLoading());
    try{

      _service.addReview(productId, ReviewModel(
        rating: rating,
        reviewerName: FirebaseAuth.instance.currentUser!.displayName??"Guest",
        userImage: FirebaseAuth.instance.currentUser!.photoURL??"https://imgs.search.brave.com/r8_rpLtbGMxU9_hP_eV66IWtpYYaUuj62TaONvbGyA8/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly91cy4x/MjNyZi5jb20vNDUw/d20vYmxpbmtibGlu/azEvYmxpbmtibGlu/azEyMDA1L2JsaW5r/YmxpbmsxMjAwNTAw/MDE1LzE0Njk3OTQ2/NC1hdmF0YXItbWFu/bi1zeW1ib2wuanBn/P3Zlcj02", 
        comment: comment));
        emit(ReviewSuccess());

    }catch(e){
      emit(ReviewError(e.toString()));
    }
  }

  Future<void> loadReviews(String productId)async{
    emit(ReviewLoading());
    try{
      final reviews = await _service.getReviews(productId);
      emit(ReviewsLoaded(reviews));
    }catch(e){
      print("Error while fetching data");
      emit(ReviewError(e.toString()));
    }
  }
}