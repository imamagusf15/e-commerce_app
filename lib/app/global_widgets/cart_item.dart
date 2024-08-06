import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/cart.dart';

// ignore: must_be_immutable
class CartItem extends StatelessWidget {
  final Cart cart;
  final TextEditingController controller;
  final bool isSelected;
  final void Function()? onTapCheckBox;
  final void Function()? onDelete;
  const CartItem({
    super.key,
    required this.isSelected,
    required this.onTapCheckBox,
    required this.onDelete,
    required this.cart,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final product = cart.product;
    return Container(
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTapCheckBox,
            child: Center(
              child: isSelected
                  ? Icon(Icons.check_box, color: Colors.lightBlue)
                  : Icon(Icons.check_box_outline_blank),
            ),
          ),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade200,
            ),
            child: product.productImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      fit: BoxFit.cover,
                      product.productImage!,
                    ),
                  )
                : Icon(Icons.image),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.productName,
                style: Get.textTheme.titleMedium,
              ),
              Text(
                'Available Stock: ${product.productStock}',
                style: Get.textTheme.bodyMedium,
              ),
              const Spacer(),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (controller.text == '1') {
                        null;
                      } else {
                        controller.text = "${int.parse(controller.text) - 1}";
                      }
                    },
                    child: const Icon(Icons.indeterminate_check_box_outlined),
                  ),
                  SizedBox(
                    width: 20,
                    child: TextFormField(
                      controller: controller..text = cart.productQty.toString(),
                      textAlign: TextAlign.center,
                      maxLength: 2,
                      decoration: const InputDecoration(
                        isDense: true,
                        counterText: '',
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (controller.text == product.productStock.toString()) {
                        null;
                      } else {
                        controller.text = "${int.parse(controller.text) + 1}";
                      }
                    },
                    child: const Icon(Icons.add_box_outlined),
                  ),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Rp. ${product.productPrice}',
                  style: Get.textTheme.titleMedium),
              const Spacer(),
              InkWell(
                onTap: onDelete,
                child: const Icon(Icons.delete),
              )
            ],
          )
        ],
      ),
    );
  }
}
