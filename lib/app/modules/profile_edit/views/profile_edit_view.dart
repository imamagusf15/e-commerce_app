import 'package:e_commerce_app/app/global_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_edit_controller.dart';

class ProfileEditView extends GetView<ProfileEditController> {
  const ProfileEditView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 54,
              // backgroundImage: AssetImage(''),
            ),
            const SizedBox(height: 8),
            GestureDetector(
                onTap: () {},
                child: const Text(
                  'Change Picture',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  ),
                )),
            const SizedBox(height: 24),
            CustomTextField(
              readOnly: true,
              controller: controller.emailController,
              labelText: 'Email',
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: controller.nameController,
              labelText: 'Name',
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: controller.phoneController,
              labelText: 'Phone',
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: controller.genderController,
              labelText: 'Gender',
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: controller.birthdayController,
              labelText: 'Birthday',
              suffixIcon: IconButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  controller.selectDate(selectedDate!);
                },
                icon: Icon(Icons.date_range),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue,
        child: ElevatedButton(
            onPressed: controller.updateUserData, child: const Text('Save')),
      ),
    );
  }
}
