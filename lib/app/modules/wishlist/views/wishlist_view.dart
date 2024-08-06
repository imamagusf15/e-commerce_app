import 'package:e_commerce_app/app/global_widgets/product_item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/wishlist_controller.dart';

class WishlistView extends GetView<WishlistController> {
  const WishlistView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist Products'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          mainAxisExtent: 225,
        ),
        itemBuilder: (context, index) => ProductItem(
          product: controller.product.value,
        ),
      ),
    );
  }
}
