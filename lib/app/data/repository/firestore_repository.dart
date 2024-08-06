import 'package:e_commerce_app/app/data/models/transaction.dart';
import 'package:e_commerce_app/app/data/services/firestore_service.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/cart.dart';
import '../models/product.dart';
import '../models/user.dart';

class FirestoreRepository {
  final _dbService = FirestoreService();
  Future<void> createUser(UserModel userModel) async {
    try {
      final docRef =
          _dbService.db.collection("users").doc(userModel.userId).withConverter(
                fromFirestore: UserModel.fromFirestore,
                toFirestore: (UserModel userModel, options) =>
                    userModel.toFirestore(),
              );
      _dbService.createToFirestore(docRef, userModel);
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateUserData(UserModel userModel) async {
    try {
      final docRef =
          _dbService.db.collection("users").doc(userModel.userId).withConverter(
                fromFirestore: UserModel.fromFirestore,
                toFirestore: (UserModel userModel, options) =>
                    userModel.toFirestore(),
              );
      _dbService.createToFirestore(docRef, userModel);
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> readUserData(String userId) async {
    try {
      final docRef = _dbService.db
          .collection("users")
          .doc(userId)
          .withConverter<UserModel>(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel userModel, options) =>
                userModel.toFirestore(),
          );
      final userModel = await _dbService.readFromFirestore(docRef) as UserModel;
      return userModel;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> createProduct(Product product) async {
    try {
      final docRef = _dbService.db.collection("products").doc().withConverter(
            fromFirestore: Product.fromFirestore,
            toFirestore: (Product product, options) => product.toFirestore(),
          );
      await _dbService.createToFirestore(docRef, product);
      return true;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Stream<List<Product>> getListProduct() {
    try {
      final colRef = _dbService.db
          .collection("products")
          .withConverter<Product>(
            fromFirestore: Product.fromFirestore,
            toFirestore: (Product product, options) => product.toFirestore(),
          );
      final listObj = _dbService.readAllDocs(colRef);
      final listProduct =
          listObj.map((list) => list.map((obj) => obj as Product).toList());
      return listProduct;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> createCartItem(String userId, Cart cart) async {
    try {
      final docRef = _dbService.db
          .collection("carts")
          .doc(userId)
          .collection('user-cart')
          .doc()
          .withConverter(
            fromFirestore: Cart.fromFirestore,
            toFirestore: (Cart cart, options) => cart.toFirestore(),
          );
      // print(docRef);
      await _dbService.createToFirestore(docRef, cart);
      return true;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Stream<List<Cart>> getUserCartProducts(String userId) {
    try {
      final colRef = _dbService.db
          .collection("carts")
          .doc(userId)
          .collection('user-cart')
          .withConverter(
            fromFirestore: Cart.fromFirestore,
            toFirestore: (Cart cart, options) => cart.toFirestore(),
          );
      final listObj = _dbService.readAllDocs(colRef);
      final listCart =
          listObj.map((list) => list.map((obj) => obj as Cart).toList());
      return listCart;
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<List<Transaction>> getUserTransactions(String userId) {
    try {
      final colRef = _dbService.db
          .collection("transactions")
          .doc(userId)
          .collection('user-transaction')
          .withConverter(
            fromFirestore: Transaction.fromFirestore,
            toFirestore: (Transaction transaction, options) =>
                transaction.toFirestore(),
          );
      final listObj = _dbService.readAllDocs(colRef);
      final listTrans =
          listObj.map((list) => list.map((obj) => obj as Transaction).toList());
      print(listTrans);
      return listTrans;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> createUserTransaction(
      String userId, Transaction transaction) async {
    try {
      final docRef = _dbService.db
          .collection("transactions")
          .doc(userId)
          .collection('user-transaction')
          .doc()
          .withConverter(
            fromFirestore: Transaction.fromFirestore,
            toFirestore: (Transaction transaction, options) =>
                transaction.toFirestore(),
          );
      // print(docRef);
      await _dbService.createToFirestore(docRef, transaction);
      return true;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteCartById(String userId, String cartId) async {
    try {
      final docRef = _dbService.db
          .collection('carts')
          .doc(userId)
          .collection('user-cart')
          .doc(cartId);

      await _dbService.deleteData(docRef);
    } catch (e) {
      throw Exception(e);
    }
  }
}
