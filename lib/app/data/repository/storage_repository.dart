import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  final _storage = FirebaseStorage.instance;

  Future<TaskSnapshot> sendProductImageToStorage({
    required File file,
    required String productName,
  }) async {
    final imageRef = _storage.ref().child("product/$productName");
    try {
      return await imageRef.putFile(file);
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }
}
