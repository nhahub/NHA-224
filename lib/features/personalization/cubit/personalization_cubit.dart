import 'package:depi_final_project/features/personalization/cubit/personalization_state.dart';
import 'package:depi_final_project/features/personalization/services/image_upload_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalizationCubit extends Cubit<PersonalizationState>{

  PersonalizationCubit(): super(PersonalizationInitial());
  ImageUploadService imageService = ImageUploadService();

  Future<void> uploadImage()async{
    emit(PersonalizationLoading());
    try{
      final imageUrl = await imageService.uploadImageUrlToFirebase();
      emit(PersonalizationSuccess(imageUrl));

    }catch(e){
      emit(PersonalizationFailure(e.toString()));
    }
  }

  Future<void> loadUserImage()async{
    emit(PersonalizationLoading());
    try{
      final String imageUrl =await imageService.fetchUserImage();
      emit(PersonalizationLoaded(imageUrl));
      print("Personalization loaded");
    }catch(e){
      emit(PersonalizationFailure(e.toString()));
    }

  }




  
}