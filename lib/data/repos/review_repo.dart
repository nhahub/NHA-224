import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depi_final_project/core/services/helper_functions.dart';
import 'package:depi_final_project/data/models/review_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReviewRepo {
  final user = FirebaseAuth.instance.currentUser!;

  Future<void> addReview(String productId, ReviewModel model) async {
    model.userId = user.uid;
    await FirebaseFirestore.instance
        .collection("products")
        .doc(productId)
        .collection("reviews")
        .doc(user.uid)
        .set(model.toFireStore());
    recalculateRating(productId);

  }

  void recalculateRating(String productId) async {
    final reviews = await getReviews(productId);
    double totalRating = 0;
    for (var review in reviews) {
      totalRating += review.rating;
    }
    double avgRating = reviews.isNotEmpty ? (totalRating / reviews.length) : 0;

    await FirebaseFirestore.instance
        .collection("products")
        .doc(productId)
        .update({'rating': avgRating});
  }


  Future<List<ReviewModel>> getReviews(String productId) async {
    try{
      final querySanpshot = await FirebaseFirestore.instance
      .collection("products")
      .doc(productId)
      .collection('reviews')
      .get();

    return querySanpshot.docs
    .map((doc) => ReviewModel.fromFireStore(doc))
    .toList();
    }catch(e){
      print("Error fetching review");
      return [];
    }
  }


  Future<void> editReview(String productId, ReviewModel model) async {
    await FirebaseFirestore.instance
        .collection("products")
        .doc(productId)
        .collection("reviews")
        .doc(user.uid)
        .update(model.toFireStore());
    recalculateRating(productId);
  }

  Future<void> deleteReview(String productId) async {
    await FirebaseFirestore.instance
        .collection("products")
        .doc(productId)
        .collection("reviews")
        .doc(user.uid)
        .delete();
    recalculateRating(productId);
  }

  bool isUserReview(String reviewUserId) {
    return reviewUserId == user.uid;
  }


  Future<void> submitReport(String productId, String reportedUserId,Map<String, bool> reportOptions) async{
    final selectedReasons = reportOptions.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    final reportData = {
      'userId': user.uid,
      'productId': productId,
      'reasons': selectedReasons,
      'reportedUserId': reportedUserId,
      'timestamp': FieldValue.serverTimestamp(),
    };

  await  FirebaseFirestore.instance
        .collection('reports')
        .add(reportData);
  }

  
}
