import 'package:e_commerce_app/app/modules/transaction_detail/controllers/transaction_detail_controller.dart';
import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionDetailView extends GetView<TransactionDetailController> {
  const TransactionDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final transaction = controller.transaction.value!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaction'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Transaction ${transaction.transactionType}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Transaction Date'),
                Text(DateFormat("yyyy-MM-dd hh:mm:ss")
                    .format(transaction.transactionDate))
              ],
            ),
            Divider(),
            Text('List Product', style: Get.textTheme.titleMedium),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 8),
              shrinkWrap: true,
              itemCount: transaction.cartList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final cart = transaction.cartList[index];
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: () => Get.toNamed(Routes.PRODUCT_DETAIL,
                            arguments: cart.product.productId),
                        contentPadding: EdgeInsets.zero,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 50,
                            width: 50,
                            color: Colors.grey.shade300,
                            child: cart.product.productImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      cart.product.productImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(Icons.image),
                          ),
                        ),
                        title: Text(cart.product.productName),
                        subtitle: Text(
                            '${cart.productQty} x Rp${cart.product.productPrice}'),
                      ),
                      Divider(),
                      Text(
                          'Total Price : Rp. ${cart.productQty * cart.product.productPrice}'),
                    ],
                  ),
                );
              },
            ),
            Divider(),
            Text('Shipping Info', style: Get.textTheme.titleMedium),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name'),
                      Text('Phone'),
                      Text('Address'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lorem ipsum '),
                      Text('01234567890'),
                      Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce sit amet mattis ligula. Vestibulum et lacus eu diam commodo aliquam sit amet vitae metus. Duis fermentum tincidunt blandit. Phasellus in molestie justo, ut auctor neque. Nullam velit metus, suscipit non magna sed, fringilla imperdiet lorem. Mauris elit massa, tincidunt in efficitur non, condimentum id mauris. Sed maximus neque lorem, eget dictum massa aliquet posuere. Maecenas ornare lectus vestibulum sapien cursus feugiat.'),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            Text('Payment Info', style: Get.textTheme.titleMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Payment Method'),
                Text('Cash on Delivery'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Price'),
                Text('Rp. ${transaction.transactionTotalPrice}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
