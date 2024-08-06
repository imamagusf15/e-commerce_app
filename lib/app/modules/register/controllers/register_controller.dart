import 'package:e_commerce_app/app/data/models/user.dart';
import 'package:e_commerce_app/app/data/repository/firestore_repository.dart';
import 'package:e_commerce_app/app/data/services/auth_service.dart';
import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final _auth = Auth();
  final _db = FirestoreRepository();
  final isLoading = false.obs;

  void register() async {
    final user = UserModel(
      name: nameController.text,
      phoneNumber: phoneController.text,
      email: emailController.text,
    );
    try {
      isLoading.value = true;
      final result = await _auth.registerUser(user, passwordController.text);
      if (result) {
        final userId = _auth.getCurrentUserId();
        final userData = await _db.readUserData(userId!);
        if (userData.isAdmin) {
          Get.offNamed(Routes.ADMIN);
        } else {
          Get.offNamed(Routes.WRAPPER);
        }
      }
      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      isLoading.value = false;
    }
  }
}
