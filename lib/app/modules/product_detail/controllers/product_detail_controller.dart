import 'package:e_commerce_app/app/data/models/product.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  //TODO: Implement ProductDetailController
  final product = Rxn<Product>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    product.value = Get.arguments as Product;
  }
}
