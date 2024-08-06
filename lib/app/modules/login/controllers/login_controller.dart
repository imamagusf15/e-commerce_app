import 'package:e_commerce_app/app/data/repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/auth_service.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = Auth();
  final _db = FirestoreRepository();
  final isLoading = false.obs;

  void login() async {
    try {
      isLoading.value = true;
      final result =
          await _auth.loginUser(emailController.text, passwordController.text);
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
