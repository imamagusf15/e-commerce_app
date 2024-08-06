import 'package:e_commerce_app/app/data/models/product.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController {
  //TODO: Implement FavoriteController

  final product = Product(
          productId: 'ID-01',
          productName: 'productName',
          productPrice: 0,
          productCategory: '0',
          productStock: 1,
          productRating: [1, 4, 6, 3],
          productImage: '')
      .obs;
}
