import 'package:e_commerce_app/app/data/repository/firestore_repository.dart';
import 'package:e_commerce_app/app/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/cart.dart';
import '../../../data/models/transaction.dart';

class CartController extends GetxController {
  //TODO: Implement CartController
  final _firestoreRepository = FirestoreRepository();
  final qtyController = <TextEditingController>[];
  final selectedCtrl = <TextEditingController>[];
  final _auth = Auth();
  final cartProduct = <Cart>[].obs;
  RxList<Cart> selectedCart = <Cart>[].obs;

  final isLoading = false.obs;

  Future<void> getUserCart() async {
    try {
      isLoading.value = true;
      final userId = _auth.getCurrentUserId();
      cartProduct.bindStream(_firestoreRepository.getUserCartProducts(userId!));
      isLoading.value = false;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      isLoading.value = false;
    }
  }

  Future<void> deleteCart(String cartId) async {
    final userId = _auth.getCurrentUserId();
    selectedCart.removeWhere((cart) => cart.cartId == cartId);
    _firestoreRepository.deleteCartById(userId!, cartId);
    // print(selectedCart[0].cartId);
  }

  void addItemsToSelected(Cart cart, TextEditingController qtyContr) {
    if (selectedCart.contains(cart)) {
      selectedCart.remove(cart);
      selectedCtrl.remove(qtyContr);
    } else {
      selectedCart.add(cart);
      selectedCtrl.add(qtyContr);
    }
  }

  bool checkIsSelected(Cart cart) {
    // selectedCart.forEach((element) => print(element.cartId));
    // selectedCart.map((e) => e.cartId).contains(cart.cartId);
    return selectedCart.contains(cart);
  }

  void checkout() {
    final cart = selectedCart.map((e) => e.product.productName).toList();
    final qty = selectedCtrl.map((e) => e.text).toList();
    print('$cart - $qty');
  }

  Future<void> createTransaction() async {
    try {
      final userId = _auth.getCurrentUserId();
      double totalTransactionPrice = 0;
      List<double> priceList = [];
      List<int> qtyList = [];
      final cartList = <Cart>[];

      selectedCart.forEach(
        (element) {
          priceList.add(element.product.productPrice);
        },
      );

      selectedCtrl.forEach((element) => qtyList.add(int.parse(element.text)));

      for (var i = 0; i < selectedCart.length; i++) {
        totalTransactionPrice += priceList[i] * qtyList[i];
        final cart = Cart(
          product: selectedCart[i].product,
          productQty: int.parse(selectedCtrl[i].text),
        );
        cartList.add(cart);
      }
      final newTransaction = Transaction(
        cartList: cartList,
        transactionDate: DateTime.now(),
        transactionTotalPrice: totalTransactionPrice,
      );
      print(totalTransactionPrice);
      await _firestoreRepository.createUserTransaction(userId!, newTransaction);
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserCart();
  }
}
