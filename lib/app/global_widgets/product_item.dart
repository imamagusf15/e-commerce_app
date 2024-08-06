import 'package:e_commerce_app/app/data/models/product.dart';
import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final void Function()? onTapCart;
  const ProductItem({super.key, required this.product, this.onTapCart});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.PRODUCT_DETAIL, arguments: product),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 2)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {},
                child: const Icon(Icons.favorite_outline),
              ),
            ),
            Center(
              child: Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300, shape: BoxShape.circle),
                child: product.productImage != null
                    ? ClipOval(
                        child: Image.network(
                          fit: BoxFit.cover,
                          product.productImage!,
                        ),
                      )
                    : Icon(Icons.image),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.productName,
              style: Get.textTheme.titleMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rp. ${product.productPrice.toString()}',
                      style: Get.textTheme.titleMedium,
                    ),
                    Row(
                      children: [
                        const Icon(
                          size: 20,
                          Icons.star,
                          color: Colors.amber,
                        ),
                        Text(product.productRating.toString()),
                      ],
                    ),
                  ],
                ),
                IconButton.filled(
                    onPressed: onTapCart, icon: Icon(Icons.add_shopping_cart))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
