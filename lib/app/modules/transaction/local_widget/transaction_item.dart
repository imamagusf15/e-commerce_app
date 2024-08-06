import 'package:e_commerce_app/app/data/models/transaction.dart';
import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  const TransactionItem({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Get.toNamed(Routes.TRANSACTION_DETAIL, arguments: transaction),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.shopify),
                Text(DateFormat('yyyy-MM-dd hh:mm:ss')
                    .format(transaction.transactionDate)),
                Spacer(),
                Text(transaction.transactionType),
              ],
            ),
            Divider(),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: transaction.cartList.length,
              itemBuilder: (context, index) {
                final cart = transaction.cartList[index];
                return ListTile(
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
                  subtitle: Text('Qty: ${cart.productQty}'),
                );
              },
            ),
            Text('Total : Rp. ${transaction.transactionTotalPrice}')
          ],
        ),
      ),
    );
  }
}
