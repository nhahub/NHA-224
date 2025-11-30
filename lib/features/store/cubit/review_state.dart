import 'package:depi_final_project/data/models/review_model.dart';
import 'package:equatable/equatable.dart';

class ReviewState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ReviewInitial extends ReviewState{}

class ReviewLoading extends ReviewState{}

class ReviewsLoaded extends ReviewState{
  final List<ReviewModel> reviews;
  ReviewsLoaded(this.reviews);
}

class ReviewSuccess extends ReviewState{}

class ReviewError extends ReviewState{
  final String message;
  ReviewError(this.message);
}

