import 'package:e_commerce_app/app/global_widgets/custom_button.dart';
import 'package:e_commerce_app/app/global_widgets/custom_textfield.dart';
import 'package:e_commerce_app/app/modules/home/local_widget/category_label.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/admin_controller.dart';

class AdminView extends GetView<AdminController> {
  const AdminView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.toNamed(Routes.PROFILE),
          icon: const Icon(Icons.person),
        ),
        backgroundColor: Colors.lightBlue,
        title: SizedBox(
          height: 40,
          child: TextField(
            onTap: () => controller.getProducts(),
            readOnly: true,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: 'Search product..',
              fillColor: Colors.white,
              filled: true,
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
          ),
        ),
      ),
      body: Obx(
        () => ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          itemCount: controller.listProduct.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final product = controller.listProduct[index];
            return Container(
              padding: const EdgeInsets.all(8),
              height: 100,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
                  ]),
              child: Row(
                children: [
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade200,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.productName,
                          style: Get.textTheme.titleMedium,
                        ),
                        Text(
                          product.productPrice.toString(),
                          style: Get.textTheme.bodyLarge,
                        ),
                        Text(
                          product.productStock.toString(),
                          style: Get.textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Icon(Icons.edit),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: const Icon(Icons.delete),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add product',
        mini: true,
        onPressed: () => Get.bottomSheet(
          AddProductView(),
          isScrollControlled: true,
          backgroundColor: Colors.white,
        ),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    AdminController controller = Get.put(AdminController());
    return Container(
      padding: const EdgeInsets.all(16),
      height: Get.height * 0.6,
      width: Get.width,
      child: ListView(
        children: [
          Center(child: Text('Add Product', style: Get.textTheme.titleMedium)),
          const SizedBox(height: 16),
          CustomTextField(
              controller: controller.nameController, labelText: 'Name'),
          const SizedBox(height: 12),
          CustomTextField(
              controller: controller.priceController, labelText: 'Price'),
          const SizedBox(height: 12),
          CustomTextField(
              controller: controller.stockController, labelText: 'Stock'),
          const SizedBox(height: 12),
          Text(
            'Product Category',
            style: Get.textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: controller.listCategories
                .map((index) => GestureDetector(
                      onTap: () => controller.changeCategory(index.toString()),
                      child: Obx(
                        () => CategoryLabel(
                          text: index,
                          isActive:
                              controller.categoryName.value == index.toString(),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 12),
          Center(
            child: Obx(
              () => InkWell(
                onTap: controller.selectedImage.value != null
                    ? null
                    : () async => await Get.defaultDialog(
                          title: 'Select Image Source',
                          content: Column(
                            children: [
                              TextButton(
                                onPressed: controller.pickImageFromCamera,
                                child: const Text('Camera'),
                              ),
                              TextButton(
                                onPressed: controller.pickImageFromGallery,
                                child: const Text('Gallery'),
                              )
                            ],
                          ),
                        ),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Obx(
                      () => controller.selectedImage.value != null
                          ? Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    controller.selectedImage.value!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: controller.removeImage,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const Center(child: Icon(Icons.add_a_photo)),
                    )),
              ),
            ),
          ),
          const SizedBox(height: 12),
          CustomButton(onPressed: controller.addProduct, text: 'Add')
        ],
      ),
    );
  }
}
