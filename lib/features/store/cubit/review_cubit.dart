import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depi_final_project/data/repos/review_repo.dart';
import 'package:depi_final_project/data/models/review_model.dart';
import 'package:depi_final_project/features/store/cubit/review_state.dart';
import 'package:depi_final_project/features/personalization/services/image_upload_service.dart';

class ReviewCubit extends Cubit<ReviewState>{

  ReviewCubit(): super(ReviewInitial());

  final ReviewRepo _service = ReviewRepo();
  Future<void> addToFirestore({required String productId, required double rating , required String comment}) async {
    emit(ReviewLoading());
    try{
      // Get user name and image from Firestore (same as profile page)
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final userDoc = await FirebaseFirestore.instance.collection("users").doc(uid).get();
      final userData = userDoc.data() as Map<String, dynamic>;
      final userName = userData["name"] ?? "Guest";

      final userImage = userData["profileImageUrl"] ?? "https://imgs.search.brave.com/r8_rpLtbGMxU9_hP_eV66IWtpYYaUuj62TaONvbGyA8/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly91cy4x/MjNyZi5jb20vNDUw/d20vYmxpbmtibGlu/azEvYmxpbmtibGlu/azEyMDA1L2JsaW5r/YmxpbmsxMjAwNTAw/MDE1LzE0Njk3OTQ2/NC1hdmF0YXItbWFu/bi1zeW1ib2wuanBn/P3Zlcj02";

      _service.addReview(productId, ReviewModel(
        rating: rating,
        reviewerName: userName,
        userImage: userImage,
        comment: comment));
        _service.recalculateRating(productId);
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


  Future<void> editReview({required String productId, required String userId,required double rating , required String comment})async{
    emit(ReviewLoading());
    try{
      // Get user name from Firestore for consistency
      final userDoc = await FirebaseFirestore.instance.collection("users").doc(userId).get();
      final userData = userDoc.data() as Map<String, dynamic>;
      final userName = userData["name"] ?? "Guest";
      final userImage = userData["profileImageUrl"] ?? "https://imgs.search.brave.com/r8_rpLtbGMxU9_hP_eV66IWtpYYaUuj62TaONvbGyA8/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly91cy4x/MjNyZi5jb20vNDUw/d20vYmxpbmtibGlu/azEvYmxpbmtibGlu/azEyMDA1L2JsaW5r/YmxpbmsxMjAwNTAw/MDE1LzE0Njk3OTQ2/NC1hdmF0YXItbWFu/bi1zeW1ib2wuanBn/P3Zlcj02";

      await _service.editReview(productId, ReviewModel(
        rating: rating,
        reviewerName: userName,
        userId: userId,
        userImage: userImage,
        comment: comment));
        _service.recalculateRating(productId);
        emit(ReviewSuccess());

    }catch(e){
      emit(ReviewError(e.toString()));
    }
  }

  Future<void> deleteReview(String productId)async{
    emit(ReviewLoading());
    try{
      await _service.deleteReview(productId);
      _service.recalculateRating(productId);
      emit(ReviewSuccess());
    }catch(e){
      emit(ReviewError(e.toString()));
    }
  }

  bool isUserReview(String reviewId){
    return _service.isUserReview(reviewId);
  }

  void submitReport(String productId,reportedUserId, Map<String, bool> reasons) async {
    emit(ReviewLoading());
    try {
      await _service.submitReport(productId ,reportedUserId , reasons);
      emit(ReviewSuccess());
    } catch (e) {
      emit(ReviewError(e.toString()));
    }
  }

  String getCurrentUserId() {
    return FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  Future<String> getCurrentUserImage() async {
    final imageService = ImageUploadService();
    return await imageService.fetchUserImage();
  }
}
