import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/user.dart';
import '../../../data/repository/firestore_repository.dart';
import '../../../data/services/auth_service.dart';

class ProfileEditController extends GetxController {
  //TODO: Implement ProfileEditController

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  final birthdayController = TextEditingController();

  final userModel = Rxn<UserModel>();
  final _auth = Auth();
  final _dbRepository = FirestoreRepository();

  final selectedDate = ''.obs;
  final isLoading = false.obs;

  void getUserData() async {
    final userId = _auth.getCurrentUserId();
    userModel.value = await _dbRepository.readUserData(userId!);
  }

  void updateUserData() {
    final newUserModel = UserModel(
      userId: userModel.value!.userId,
      email: userModel.value!.email,
      isAdmin: userModel.value!.isAdmin,
      name: nameController.text,
      phoneNumber: phoneController.text,
      gender: genderController.text,
      userAddress: userModel.value!.userAddress,
      birthday: DateTime.parse(birthdayController.text),
    );
    try {
      isLoading.value = true;
      _dbRepository.createUser(newUserModel);
      Get.snackbar('Success', 'Profile has successfully updated');
      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void selectDate(DateTime date) {
    selectedDate.value = DateFormat("yyyy-MM-dd").format(date);
    birthdayController.text = selectedDate.value;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userModel.value = Get.arguments as UserModel;
    // getUserData();
    emailController.text = userModel.value!.email;
    nameController.text = userModel.value!.name;
    phoneController.text = userModel.value!.phoneNumber;
    if (userModel.value!.gender != null) {
      genderController.text = userModel.value!.gender!;
    }
    birthdayController.text = userModel.value!.birthday != null
        ? DateFormat("yyyy-MM-dd").format(userModel.value!.birthday!)
        : '';
  }
}
