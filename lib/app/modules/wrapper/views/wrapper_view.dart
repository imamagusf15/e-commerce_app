import 'package:e_commerce_app/app/modules/transaction/views/transaction_view.dart';
import 'package:e_commerce_app/app/modules/wishlist/views/wishlist_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/wrapper_controller.dart';

class WrapperView extends GetView<WrapperController> {
  const WrapperView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: [
            HomeView(),
            WishlistView(),
            TransactionView(),
            ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: (value) {
            controller.currentIndex.value = value;
          },
          backgroundColor: Colors.lightBlue,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite),
              label: 'Wishlist',
            ),
            NavigationDestination(
              icon: Icon(Icons.receipt),
              label: 'Transaction',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
