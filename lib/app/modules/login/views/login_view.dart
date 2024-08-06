import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/custom_textfield.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
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
                'Login',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                labelText: 'Email',
                controller: controller.emailController,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                labelText: 'Password',
                controller: controller.passwordController,
              ),
              const SizedBox(height: 16),
              Obx(() => controller.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomButton(onPressed: controller.login, text: 'Login')),
              // OutlinedButton(
              //   onPressed: () {},
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Icon(Icons.g_mobiledata),
              //       Text('Login With Google'),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Doesn't have an account? ",
                        style: Get.textTheme.bodyMedium),
                    TextSpan(
                      text: 'Register',
                      style: Get.textTheme.bodyMedium!
                          .copyWith(color: Colors.lightBlue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.offNamed(Routes.REGISTER),
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
