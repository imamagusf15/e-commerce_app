import 'package:e_commerce_app/app/data/models/user.dart';
import 'package:e_commerce_app/app/data/repository/firestore_repository.dart';
import 'package:e_commerce_app/app/data/services/auth_service.dart';
import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final userModel = Rxn<UserModel>();
  final _auth = Auth();
  final _dbRepository = FirestoreRepository();
  final isLoading = false.obs;

  void getUserData() async {
    final userId = _auth.getCurrentUserId();
    await _dbRepository
        .readUserData(userId!)
        .then((value) => userModel.value = value);
  }

  void logout() async {
    try {
      isLoading.value = true;
      await _auth.userLogout();
      Get.offNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getUserData();
  }
}
