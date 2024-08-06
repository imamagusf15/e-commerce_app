import 'package:e_commerce_app/app/modules/transaction/local_widget/transaction_item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Transaction'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.separated(
          padding: EdgeInsets.all(16),
          separatorBuilder: (context, index) => SizedBox(height: 12),
          itemCount: controller.transactionList.length,
          itemBuilder: (context, index) => TransactionItem(
            transaction: controller.transactionList[index],
          ),
        ),
      ),
    );
  }
}
