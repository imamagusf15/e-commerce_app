import 'package:e_commerce_app/app/global_widgets/product_item.dart';
import 'package:e_commerce_app/app/modules/home/local_widget/category_label.dart';
import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: TextField(
            onTap: () => Get.toNamed(Routes.SEARCH),
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
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.CART),
            icon: Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Get.width,
              height: 50,
              child: Obx(
                () => ListView.separated(
                  clipBehavior: Clip.none,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.productCategories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final category =
                        controller.productCategories.elementAt(index);
                    return Obx(
                      () => GestureDetector(
                        onTap: () => controller.changeCategory(category),
                        child: CategoryLabel(
                          isActive: controller.categoryName.value == category,
                          text: category,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Products',
              style: Get.textTheme.headlineLarge,
            ),
            SizedBox(height: 12),
            Obx(
              () => SizedBox(
                width: Get.width,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 210,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2,
                  ),
                  itemCount: controller.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = controller.filteredProducts[index];
                    // final productByCategory = controller.listProduct.where(
                    //   (product) {
                    //     return product.productCategory ==
                    //         controller.categoryName.value;
                    //   },
                    // ).toList();

                    // if (controller.categoryName.value != 'All Product') {
                    //   if (index < productByCategory.length) {
                    //     return ProductItem(
                    //       onTapCart: () => controller.addToCart(
                    //           product: productByCategory[index]),
                    //       product: productByCategory[index],
                    //     );
                    //   } else {
                    //     return const SizedBox();
                    //   }
                    // } else {
                    // }
                    return ProductItem(
                      onTapCart: () => controller.addToCart(product: product),
                      product: product,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
