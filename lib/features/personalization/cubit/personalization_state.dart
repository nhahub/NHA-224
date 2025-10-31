import 'package:equatable/equatable.dart';

class PersonalizationState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PersonalizationInitial extends PersonalizationState{}
class PersonalizationLoading extends PersonalizationState{}
class PersonalizationLoaded extends PersonalizationState{
  final String imageUrl;
  PersonalizationLoaded(this.imageUrl);
}
class PersonalizationSuccess extends PersonalizationState{
  final String imageUrl;
  // TODO: add the reset profile probs
  PersonalizationSuccess(this.imageUrl);
}
class PersonalizationFailure extends PersonalizationState{
  final String message;
  PersonalizationFailure(this.message);
}