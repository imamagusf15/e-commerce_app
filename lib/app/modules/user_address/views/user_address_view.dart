import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_address_controller.dart';

class UserAddressView extends GetView<UserAddressController> {
  const UserAddressView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address List'),
        actions: [
          GestureDetector(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Add Address',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  ),
                ),
              )),
        ],
      ),
      body: const Center(
        child: Text(
          'UserAddressView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
