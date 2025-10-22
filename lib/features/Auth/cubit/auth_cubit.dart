import 'package:bloc/bloc.dart';
import 'package:depi_final_project/features/Auth/cubit/auth_state.dart';
import 'package:depi_final_project/features/Auth/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthCubit extends Cubit<AuthState> {

  final AuthService _authService = AuthService();

  AuthCubit() : super(AuthInitial());

  Future<void> loginUser({required BuildContext context ,required String email,required String password}) async {
    emit(AuthLoading());
    try {
      final user = await _authService.loginUser(context: context, email: email, password: password);
      emit(AuthSuccess(user!.uid));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthFailure("User not found"));
      } else if (e.code == 'wrong-password') {
        emit(AuthFailure("Wrong password"));
      }else if(e.code == "email-not-verified"){
        emit(AuthFailure("Please verify your email first"));
      }
      
       else {
        emit(AuthFailure(e.message ?? "Login failed"));
      }
    } catch (e) {
      emit(AuthFailure("Unexpected error"));
    }
  }




  Future<void> registerUser({required BuildContext context, required String name ,required String email, required String password, required String photoURL}) async {
    emit(AuthLoading());
    try {
      final user = await _authService.registerUser(context: context,name: name, email: email, password: password, profileImageUrl: photoURL);
      emit(AuthSuccess(user!.uid));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthFailure("Weak password"));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthFailure("Email already in use"));
      } else {
        emit(AuthFailure(e.message ?? "Register failed"));
      }
    } catch (e) {
      emit(AuthFailure("Unexpected error"));
    }
  }

  
}
