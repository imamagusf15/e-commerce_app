import 'package:e_commerce_app/app/global_widgets/cart_item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        centerTitle: true,
      ),
      body: controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemCount: controller.cartProduct.length,
                itemBuilder: (context, index) {
                  final cart = controller.cartProduct[index];
                  controller.qtyController.add(TextEditingController());
                  if (controller.cartProduct.length == 0) {
                    return Center(child: Text('No cart'));
                  } else {
                    return Obx(
                      () => CartItem(
                        onTapCheckBox: () => controller.addItemsToSelected(
                            cart, controller.qtyController[index]),
                        onDelete: () => controller.deleteCart(cart.cartId!),
                        isSelected: controller.checkIsSelected(cart),
                        cart: cart,
                        controller: controller.qtyController[index],
                      ),
                    );
                  }
                },
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        child: ElevatedButton(
            onPressed: () {
              controller.createTransaction();
            },
            child: Text('Checkout')),
      ),
    );
  }
}
