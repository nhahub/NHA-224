import 'package:equatable/equatable.dart';

class PersonalizationState extends Equatable{
  @override
  List<Object?> get props => [];
}

class PersonalizationInitial extends PersonalizationState{}
class PersonalizationLoading extends PersonalizationState{}
class PersonalizationLoaded extends PersonalizationState{
  final String imageUrl;
  PersonalizationLoaded(this.imageUrl);
}

class PersonalizationLoadedd extends PersonalizationState {
  final String name;
  final String email;

  PersonalizationLoadedd({
    required this.name,
    required this.email,
  });
}



class PersonalizationSuccess extends PersonalizationState{
  final String imageUrl;
  PersonalizationSuccess(this.imageUrl);
}
class PersonalizationFailure extends PersonalizationState{
  final String message;
  PersonalizationFailure(this.message);
}