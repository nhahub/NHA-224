import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depi_final_project/features/Auth/cubit/auth_state.dart';
import 'package:depi_final_project/features/Auth/services/auth_service.dart';
import 'package:depi_final_project/core/services/shared_preferences_service.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService = AuthService();
  final SharedPreferencesService _prefsService = SharedPreferencesService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthCubit() : super(AuthInitial());

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final user = await _authService.loginUser(
        email: email,
        password: password,
      );
      
      if (user != null) {
        // Fetch user role from Firestore
        final userDoc = await _firestore.collection('users').doc(user.uid).get();
        final role = userDoc.data()?['role'] ?? 'user';
        final name = userDoc.data()?['name'] ?? '';
        final profileImageUrl = userDoc.data()?['profileImageUrl'] ?? '';
        
        // Save login state to SharedPreferences
        await _prefsService.saveLoginState(
          userId: user.uid,
          email: email,
          role: role,
          name: name,
          profileImageUrl: profileImageUrl,
        );
        
        emit(AuthSuccess(user.uid));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthFailure("User not found"));
      } else if (e.code == 'wrong-password') {
        emit(AuthFailure("Wrong password"));
      } else if (e.code == "email-not-verified") {
        emit(AuthFailure("Please verify your email first"));
      } else {
        emit(AuthFailure(e.message ?? "Login failed"));
      }
    } catch (e) {
      emit(AuthFailure("Unexpected error"));
    }
  }

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String photoURL,
  }) async {
    emit(AuthLoading());
    try {
      final user = await _authService.registerUser(
        name: name,
        email: email,
        password: password,
        profileImageUrl: photoURL,
      );
      
      if (user != null) {
        // Save login state for new user
        await _prefsService.saveLoginState(
          userId: user.uid,
          email: email,
          role: 'user',
          name: name,
          profileImageUrl: photoURL,
        );
        
        emit(AuthSuccess(user.uid));
      }
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

  Future<void> loginWithGoogle() async {
    emit(AuthLoading());
    try {
      final userCredential = await _authService.loginWithGoogle();
      final user = userCredential.user;
      
      if (user != null) {
        // Fetch user role from Firestore
        final userDoc = await _firestore.collection('users').doc(user.uid).get();
        final role = userDoc.data()?['role'] ?? 'user';
        final name = user.displayName ?? '';
        final profileImageUrl = user.photoURL ?? '';
        
        // Save login state
        await _prefsService.saveLoginState(
          userId: user.uid,
          email: user.email ?? '',
          role: role,
          name: name,
          profileImageUrl: profileImageUrl,
        );
        
        emit(AuthSuccess(user.uid));
      }
    } on FirebaseAuthException {
      emit(AuthFailure("Google sign-in failed"));
    } catch (e) {
      emit(AuthFailure("Unexpected error"));
    }
  }

  /// Logout and clear session
  Future<void> logout() async {
    try {
      await _prefsService.clearLoginState();
      await _authService.signOutFirebase();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure("Logout failed"));
    }
  }

  /// Check if user is already logged in (restore session)
  Future<void> checkLoginStatus() async {
    if (_prefsService.isLoggedIn) {
      emit(AuthSuccess(_prefsService.userId));
    } else {
      emit(AuthInitial());
    }
  }
}

