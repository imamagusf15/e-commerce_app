import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/app/data/models/product.dart';

class Cart {
  String? cartId;
  Product product;
  int productQty;

  Cart({
    this.cartId,
    required this.product,
    this.productQty = 1,
  });

  factory Cart.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    final product = Product(
      productId: data?['productId'],
      productName: data?['productName'],
      productCategory: data?['productCategory'],
      productImage: data?['productImage'],
      productPrice: data?['productPrice'],
      productStock: data?['productStock'],
    );
    return Cart(
      cartId: snapshot.id,
      product: product,
      productQty: data?['productQty'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      "productId": product.productId,
      "productName": product.productName,
      "productPrice": product.productPrice,
      "productCategory": product.productCategory,
      "productStock": product.productStock,
      "productImage": product.productImage,
      "productQty": productQty,
    };
  }
}
