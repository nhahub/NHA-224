import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depi_final_project/data/models/review_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReviewService {

  final user = FirebaseAuth.instance.currentUser!;

  Future<void> addReview(String productId, ReviewModel model) async {
    model.userId = user.uid;
    await FirebaseFirestore.instance
        .collection("products")
        .doc(productId)
        .collection("reviews")
        .doc(user.uid)
        .set(model.toFireStore());
  }
}
