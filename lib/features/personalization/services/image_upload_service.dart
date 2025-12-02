import 'dart:convert';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageUploadService {
  // Default fallback values
  static const String defaultCloudName = "dp9lb4oie";
  static const String defaultUploadPreset = "profile_preset";
  static const String defaultFolder = "profile_images";

  String? imageUrl;

  // Get Cloudinary configuration from SharedPreferences (admin settings)
  Future<Map<String, String>> _getCloudinaryConfig() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'cloudName': prefs.getString('cloudinary_cloud_name') ?? defaultCloudName,
      'uploadPreset': prefs.getString('cloudinary_upload_preset') ?? defaultUploadPreset,
      'folder': prefs.getString('cloudinary_folder') ?? defaultFolder,
    };
  }

  Future<String> uploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null)
      return "https://imgs.search.brave.com/r8_rpLtbGMxU9_hP_eV66IWtpYYaUuj62TaONvbGyA8/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly91cy4x/MjNyZi5jb20vNDUw/d20vYmxpbmtibGlu/azEvYmxpbmtibGlu/azEyMDA1L2JsaW5r/YmxpbmsxMjAwNTAw/MDE1LzE0Njk3OTQ2/NC1hdmF0YXItbWFu/bi1zeW1ib2wuanBn/P3Zlcj02";

    try {
      final config = await _getCloudinaryConfig();
      final bytes = await image.readAsBytes();

      // Cloudinary upload URL
      final url = Uri.parse(
        "https://api.cloudinary.com/v1_1/${config['cloudName']}/image/upload",
      );

      // Multi part request
      final request = http.MultipartRequest('POST', url);
      request.fields['upload_preset'] = config['uploadPreset']!;

      // Optional folder
      request.fields['folder'] = config['folder']!;

      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: basename(image.path),
        ),
      );

      final response = await request.send();
      final respStr = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResp = json.decode(respStr);
        final String secureUrl = jsonResp['secure_url'] ?? jsonResp['url'];
        return secureUrl;
      } else {
        final Map<String, dynamic> err = (respStr.isNotEmpty
            ? json.decode(respStr)
            : null);
        final message = err?['error']?['message'] ?? 'Upload failed: ${response.statusCode}';
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Image upload failed: $e');
    }
  }

  Future<String> uploadImageUrlToFirebase() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final imageUrl = await uploadImage();
    await FirebaseFirestore.instance.collection("users").doc(userId).set({
      "profileImageUrl": imageUrl,
    }, SetOptions(merge: true));
    return imageUrl;
  }

  Future<String> fetchUserImage() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get();
    if (snapshot.exists) {
      final imageUrl = snapshot.data()?["profileImageUrl"];
      return imageUrl ?? "https://imgs.search.brave.com/r8_rpLtbGMxU9_hP_eV66IWtpYYaUuj62TaONvbGyA8/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly91cy4x/MjNyZi5jb20vNDUw/d20vYmxpbmtibGlu/azEvYmxpbmtibGlu/azEyMDA1L2JsaW5r/YmxpbmsxMjAwNTAw/MDE1LzE0Njk3OTQ2/NC1hdmF0YXItbWFu/bi1zeW1ib2wuanBn/P3Zlcj02";
    }

    return "https://imgs.search.brave.com/r8_rpLtbGMxU9_hP_eV66IWtpYYaUuj62TaONvbGyA8/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly91cy4x/MjNyZi5jb20vNDUw/d20vYmxpbmtibGlu/azEvYmxpbmtibGlu/azEyMDA1L2JsaW5r/YmxpbmsxMjAwNTAw/MDE1LzE0Njk3OTQ2/NC1hdmF0YXItbWFu/bi1zeW1ib2wuanBn/P3Zlcj02";
  }
}
