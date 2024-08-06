import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../controllers/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final product = controller.product.value!;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 300,
              backgroundColor: Colors.lightBlue,
              flexibleSpace: FlexibleSpaceBar(
                background: product.productImage != null
                    ? Image.network(
                        fit: BoxFit.cover,
                        product.productImage!,
                      )
                    : Container(
                        color: Colors.grey.shade200,
                        child: Center(child: Icon(Icons.image))),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    Text(
                      'Rp. ${product.productPrice.toString()}',
                      style: Get.textTheme.headlineSmall,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.productName,
                          style: Get.textTheme.titleLarge,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.favorite_outline),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        Text(
                          '${product.productRating.toString()}',
                          style: Get.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Divider(),
                    Text(
                      'Description',
                      style: Get.textTheme.titleMedium,
                    ),
                    Text('Product Description',
                        style: Get.textTheme.bodyMedium),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: 12),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) => Placeholder(
                        child: SizedBox(
                          height: 200,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Add to cart'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
