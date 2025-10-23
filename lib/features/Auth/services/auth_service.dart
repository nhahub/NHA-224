// ignore_for_file: use_build_context_synchronously


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depi_final_project/core/errors/failures.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  

  // تسجيل خروج
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login, // استخدم الروت المعرّف في ملف AppRoutes
      (Route<dynamic> route) => false, // امسح كل الصفحات القديمة
    );
  }

  // تسجيل دخول مع التحقق من الدور
  Future<User?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user != null && user.emailVerified) {
        // جلب بيانات المستخدم من Firestore
        // DocumentSnapshot userDoc = await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(user.uid)
        //     .get();

        // String role = userDoc['role'] ?? 'user';

        // if (role == 'admin') {
        //   // لو الأدمن
        //   Navigator.pushReplacementNamed(context, AppRoutes.adminPage);
        // } else {
        //   // لو مستخدم عادي
        //   Navigator.pushReplacementNamed(
        //     context,
        //     AppRoutes.layout,
        //     arguments: email,
        //   );
        // }
        return userCredential.user;
      } else {
        // لو الإيميل مش متحقق
        // showSnackBar(context, 'Please verify your email first.');

        await _auth.signOut();
        throw FirebaseAuthException(code: "email-not-verified", message: "Email Not verified");
      }
    } on FirebaseAuthException catch (e) {
      // showSnackBar(context, e.message ?? 'Login error.');
      rethrow;
    } catch (e) {
      // showSnackBar(context, 'An unexpected error occurred: $e');
      print('An unexpected error occurred: $e');
      rethrow;
      // print('Login error: $e');
    }
  }

  // تسجيل مستخدم جديد مع حفظ الاسم والصورة
  Future<User?> registerUser({
    required String email,
    required String password,
    required String name,
    String? profileImageUrl,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;

      if (user != null) {
        await user.sendEmailVerification();

        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name,
          'email': email,
          'profileImageUrl': profileImageUrl ?? '',
          'role': 'user',
        });

        return user;
      }
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      // print('Unexpected error: $e');
      rethrow;
    }
    return null;
  }

   Future<UserCredential> loginWithGoogle() async {
    try {

      final String serverClientId = dotenv.env['server_client_id']??"no id";
      //initialize google sign in
      await GoogleSignIn.instance.initialize(serverClientId: serverClientId);

      final GoogleSignInAccount? googleUser = await GoogleSignIn.instance.authenticate();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;
      await _firestore.collection('users').doc(user!.uid).set({
          'uid': user.uid,
          'name': user.displayName??"Guest",
          'email': user.email??"No Email",
          'profileImageUrl': user.photoURL??"https://imgs.search.brave.com/r8_rpLtbGMxU9_hP_eV66IWtpYYaUuj62TaONvbGyA8/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly91cy4x/MjNyZi5jb20vNDUw/d20vYmxpbmtibGlu/azEvYmxpbmtibGlu/azEyMDA1L2JsaW5r/YmxpbmsxMjAwNTAw/MDE1LzE0Njk3OTQ2/NC1hdmF0YXItbWFu/bi1zeW1ib2wuanBn/P3Zlcj02",
          'role': 'user',
        });
        
        // DocumentSnapshot userDoc = await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(user.uid)
        //     .get();

        // String role = userDoc['role'] ?? 'user';
        // if(role == 'admin'){
        //   Navigator.pushReplacementNamed(context, AppRoutes.adminPage);
        // }else{
        //   Navigator.pushReplacementNamed(
        //     context,
        //     AppRoutes.layout,
        //     arguments: user.email,
        //   );
        // }
      
      // Once signed in, return the UserCredential
      return userCredential;
    } catch (e) {
      print('Google sign-in error: $e');
      rethrow;
    }
  }

// Future<UserCredential> signInWithGoogle() async {
//   // إعداد GoogleSignIn بالـ clientId
//   final GoogleSignIn googleSignIn = GoogleSignIn(
//     serverClientId: '661720149477-3fq4avjj9h77o9oikhlhqhd177jgkdt5.apps.googleusercontent.com',
//   );

//   // تسجيل الدخول
//   final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//   if (googleUser == null) {
//     throw Exception('Sign in aborted by user');
//   }

//   // الحصول على بيانات التوكن
//   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//   // إنشاء credential لاستخدامه في Firebase Auth
//   final credential = GoogleAuthProvider.credential(
//     idToken: googleAuth.idToken,
//     accessToken: googleAuth.idToken,
//   );

//   // تسجيل الدخول في Firebase
//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }



//  Future<UserCredential> signInWithGoogle() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount? googleUser =
//         await GoogleSignIn.instance.authenticate();

//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication googleAuth = googleUser!.authentication;

//     // Create a new credential
//     final credential = GoogleAuthProvider.credential(
//       idToken: googleAuth.idToken,
//     );

//     // Once signed in, return the UserCredential
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }



  // رفع صورة على Cloudinary
  // Future<String?> uploadImageToCloudinary(File file) async {
  //   try {
  //     String cloudName = 'drlr0etui';       // Cloud Name بتاعك
  //     String uploadPreset = 'ml_default';   // Upload Preset اللي عملتهللي عملته

  //     var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload'),
  //     );

  //     request.files.add(await http.MultipartFile.fromPath('file', file.path));
  //     request.fields['upload_preset'] = uploadPreset;

  //     var response = await request.send();
  //     var resData = await http.Response.fromStream(response);
  //     var jsonData = json.decode(resData.body);

  //     return jsonData['secure_url']; // رابط الصورة النهائي
  //   } catch (e) {
  //     print('Cloudinary upload error: $e');
  //     return null;
  //   }
  // }

  // ---- Reset Password ----
  Future<void> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showSnackBar(context, 'Reset password email sent! Check your inbox.');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message ?? 'Error sending reset email.');
    } catch (e) {
      showSnackBar(context, 'An unexpected error occurred.');
    }
  }
}
