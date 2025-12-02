import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depi_final_project/features/personalization/cubit/personalization_state.dart';
import 'package:depi_final_project/features/personalization/services/image_upload_service.dart';

class PersonalizationCubit extends Cubit<PersonalizationState> {
  PersonalizationCubit() : super(PersonalizationInitial());
  ImageUploadService imageService = ImageUploadService();

 Future<void> uploadImage() async {
  emit(PersonalizationLoading());

  try {
    final imageUrl = await imageService.uploadImageUrlToFirebase();

    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"profileImageUrl": imageUrl});

    emit(PersonalizationSuccess(imageUrl));
  } catch (e) {
    emit(PersonalizationFailure(e.toString()));
  }
}

Future<void> updateName(String newName) async {
  emit(PersonalizationLoading());

  try {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"name": newName});

    
    await loadUserData();

    emit(PersonalizationSuccess("Name updated"));
  } catch (e) {
    emit(PersonalizationFailure("Error updating name"));
  }
}


  Future<void> loadUserImage() async {
    emit(PersonalizationLoading());
    try {
      final String imageUrl = await imageService.fetchUserImage();
      emit(PersonalizationLoaded(imageUrl));
    } catch (e) {
      emit(PersonalizationFailure(e.toString()));
    }
  }
  Future<void> loadUserData() async {
  emit(PersonalizationLoading());

  try {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();

    final data = snap.data() as Map<String, dynamic>;

    emit(PersonalizationLoadedd(
      name: data["name"] ?? "",
      email: data["email"] ?? "",
    ));
  } catch (e) {
    emit(PersonalizationFailure(  e.toString()));
  }
}

  Future<void> loadCompleteUserData() async {
    emit(PersonalizationLoading());

    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      final snap = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get();

      if (snap.exists) {
        final data = snap.data() as Map<String, dynamic>;

        emit(PersonalizationDataLoaded(
          name: data["name"] ?? "",
          email: data["email"] ?? "",
          imageUrl: data["profileImageUrl"],
        ));
      } else {
        emit(PersonalizationFailure("User data not found"));
      }
    } catch (e) {
      emit(PersonalizationFailure(e.toString()));
    }
  }


}
