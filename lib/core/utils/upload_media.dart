import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadProfileImage(String uid,File? pickedFile) async {
    try {

      if (pickedFile == null) return null;

      File file = File(pickedFile.path);

      // Create a reference in Firebase Storage
      final ref = _storage.ref().child('profile_pictures').child('$uid.jpg');

      // Upload file
      await ref.putFile(file);

      // Get download URL
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Upload error: $e");
      return null;
    }
  }
}
