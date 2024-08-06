import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/app/data/models/cart.dart';
import 'package:e_commerce_app/app/data/models/product.dart';

class Transaction {
  String? transactionId;
  List<Cart> cartList;
  String transactionType;
  double transactionTotalPrice;
  DateTime transactionDate;

  Transaction({
    this.transactionId,
    required this.cartList,
    this.transactionType = "Success",
    required this.transactionDate,
    required this.transactionTotalPrice,
  });

  factory Transaction.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Transaction(
      cartList: (data?['cartList'] as List)
          .cast<Map<String, dynamic>>()
          .map(
            (data) => Cart(
              product: Product(
                productName: data['productName'],
                productPrice: data['productPrice'],
                productStock: data['productStock'],
                productCategory: data['productCategory'],
                productImage: data['productImage'],
              ),
              productQty: data['productQty'],
            ),
          )
          .toList(),
      transactionType: data?['transactionType'],
      transactionDate: (data?['transactionDate'] as Timestamp).toDate(),
      transactionTotalPrice: data?['transactionTotalPrice'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "cartList": cartList
          .map((cart) => {
                "productId": cart.product.productId,
                "productName": cart.product.productName,
                "productPrice": cart.product.productPrice,
                "productCategory": cart.product.productCategory,
                "productStock": cart.product.productStock,
                "productImage": cart.product.productImage,
                "productQty": cart.productQty,
              })
          .toList(),
      "transactionType": transactionType,
      "transactionDate": transactionDate,
      "transactionTotalPrice": transactionTotalPrice,
    };
  }
}
