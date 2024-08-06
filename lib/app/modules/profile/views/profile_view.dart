import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const CircleAvatar(
                    radius: 72,
                    // backgroundImage: AssetImage(''),
                  ),
                  const SizedBox(height: 12),
                  Obx(() => Text(controller.userModel.value?.name ?? '',
                      style: Get.textTheme.headlineSmall)),
                  const SizedBox(height: 48),
                  ListTile(
                    onTap: () => Get.toNamed(Routes.PROFILE_EDIT,
                        arguments: controller.userModel.value),
                    leading: const Icon(Icons.person),
                    title: const Text('Edit Profile'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    onTap: () => Get.toNamed(Routes.USER_ADDRESS),
                    leading: const Icon(Icons.location_on),
                    title: const Text('Your Address'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  ListTile(
                    onTap: controller.logout,
                    title: const Text('Logout'),
                    trailing: const Icon(Icons.logout),
                  ),
                ],
              ),
      ),
    );
  }
}
