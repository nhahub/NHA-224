import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String? userId;
  double rating;
  String reviewerName;
  String userImage;
  String comment;

  ReviewModel({
 this.userId,
   required this.rating,
   required this.reviewerName,
   required this.userImage,
   required this.comment
  });

  factory ReviewModel.fromFireStore(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return  ReviewModel(
      userId: data['userId'] as String,
      rating: data['rating'] as double, 
      reviewerName: data['reviewerName'] as String,
      userImage: data['userImage'], 
      comment: data['comment']);

  }


  Map<String, dynamic> toFireStore(){
    return {
      'userId': userId,
      'rating': rating,
      'reviewerName': reviewerName,
      'userImage': userImage,
      'comment': comment,
    };
  }
}