import 'package:e_commerce_app/app/data/models/transaction.dart';
import 'package:e_commerce_app/app/data/repository/firestore_repository.dart';
import 'package:e_commerce_app/app/data/services/auth_service.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  //TODO: Implement TransactionController
  final transactionList = <Transaction>[].obs;
  final _auth = Auth();
  final _firestoreRepository = FirestoreRepository();
  final isLoading = false.obs;

  Future<void> getUserTransactions() async {
    try {
      isLoading.value = true;
      final userId = _auth.getCurrentUserId();
      transactionList
          .bindStream(_firestoreRepository.getUserTransactions(userId!));
      isLoading.value = false;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserTransactions();
  }
}
