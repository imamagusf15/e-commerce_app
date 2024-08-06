import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? productId;
  String productName;
  String productCategory;
  double productPrice;
  String? productImage;
  int productStock;
  List<int>? productRating;

  Product({
    this.productId,
    required this.productName,
    required this.productPrice,
    required this.productStock,
    required this.productCategory,
    this.productImage,
    this.productRating,
  });

  factory Product.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Product(
      productId: snapshot.id,
      productName: data?['productName'],
      productPrice: data?['productPrice'],
      productStock: data?['productStock'],
      productCategory: data?['productCategory'],
      productImage: data?['productImage'],
      productRating: data?['productRating'] is Iterable
          ? List.from(data?['productRating'])
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "productName": productName,
      "productPrice": productPrice,
      "productCategory": productCategory,
      "productStock": productStock,
      "productImage": productImage,
      "productRating": productRating,
    };
  }
}
