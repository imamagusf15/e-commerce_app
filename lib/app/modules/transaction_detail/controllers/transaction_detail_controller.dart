import 'package:get/get.dart';

import '../../../data/models/transaction.dart';

class TransactionDetailController extends GetxController {
  final transaction = Rxn<Transaction>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    transaction.value = Get.arguments as Transaction;
  }
}
