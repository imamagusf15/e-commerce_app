import 'package:e_commerce_app/app/global_widgets/custom_button.dart';
import 'package:e_commerce_app/app/global_widgets/custom_textfield.dart';
import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Register',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                labelText: 'Name',
                controller: controller.nameController,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                labelText: 'Email',
                controller: controller.emailController,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                labelText: 'Password',
                controller: controller.passwordController,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                labelText: 'Phone',
                controller: controller.phoneController,
              ),
              const SizedBox(height: 16),
              Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomButton(
                        onPressed: controller.register, text: 'Register'),
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Already have an account? ",
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                      text: 'Login',
                      style: Get.textTheme.bodyMedium!
                          .copyWith(color: Colors.lightBlue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.offNamed(Routes.LOGIN),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
