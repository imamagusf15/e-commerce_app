import 'package:e_commerce_app/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:e_commerce_app/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:e_commerce_app/app/modules/home/controllers/home_controller.dart';
import 'package:e_commerce_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../controllers/wrapper_controller.dart';

class WrapperBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WrapperController>(
      () => WrapperController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<WishlistController>(
      () => WishlistController(),
    );
    Get.lazyPut<TransactionController>(
      () => TransactionController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
