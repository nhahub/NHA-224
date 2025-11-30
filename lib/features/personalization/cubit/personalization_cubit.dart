import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depi_final_project/features/personalization/cubit/personalization_state.dart';
import 'package:depi_final_project/features/personalization/services/image_upload_service.dart';

class PersonalizationCubit extends Cubit<PersonalizationState> {
  PersonalizationCubit() : super(PersonalizationInitial());
  ImageUploadService imageService = ImageUploadService();

 Future<void> uploadImage() async {
  emit(PersonalizationLoading());

  try {
    // 1) ارفع الصورة وخد رابطها
    final imageUrl = await imageService.uploadImageUrlToFirebase();

    // 2) حفظ الرابط في Firestore
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"imageUrl": imageUrl});

    // 3) رجّع الستيت باللينك الجديد
    emit(PersonalizationSuccess(imageUrl));
  } catch (e) {
    emit(PersonalizationFailure(e.toString()));
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


}
