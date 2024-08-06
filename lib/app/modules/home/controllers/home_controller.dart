import 'package:e_commerce_app/app/data/models/cart.dart';
import 'package:e_commerce_app/app/data/models/product.dart';
import 'package:e_commerce_app/app/data/repository/firestore_repository.dart';
import 'package:e_commerce_app/app/data/services/auth_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final _firestoreRepository = FirestoreRepository();
  final _auth = Auth();

  final currentIndex = 0.obs;
  final isActive = false.obs;
  final categoryName = '0'.obs;
  final listProduct = <Product>[].obs;
  final productCategories = <String>{}.obs;
  final filteredProducts = <Product>[].obs;

  void changeCategory(String category) {
    categoryName.value = category;
  }

  void filterProducts() {
    if (categoryName.value == 'All Product') {
      filteredProducts.assignAll(listProduct);
    } else {
      filteredProducts.assignAll(
        listProduct
            .where((product) => product.productCategory == categoryName.value)
            .toList(),
      );
    }
  }

  Future<void> getProducts() async {
    _firestoreRepository.getListProduct().listen(
      (index) {
        listProduct.clear();
        productCategories.clear();
        productCategories.add('All Product');
        for (var element in index) {
          listProduct.add(element);
          productCategories.add(element.productCategory);
        }
        categoryName.value = 'All Product';
        filterProducts();
      },
    );
  }

  Future<void> addToCart({required Product product}) async {
    try {
      final userId = _auth.getCurrentUserId();
      final newCart = Cart(product: product, productQty: 1);
      await _firestoreRepository.createCartItem(userId!, newCart);
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    // Listen to changes in categoryName and update filteredProducts
    ever(categoryName, (_) {
      filterProducts();
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProducts();
  }
}
