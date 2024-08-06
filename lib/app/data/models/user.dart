import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId;
  String name;
  String phoneNumber;
  String email;
  String? gender;
  DateTime? birthday;
  String? userAddress;
  bool isAdmin;

  UserModel({
    this.gender,
    this.birthday,
    this.userId,
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.userAddress,
    this.isAdmin = false,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      userId: snapshot.id,
      name: data?['name'],
      phoneNumber: data?['phoneNumber'],
      email: data?['email'],
      gender: data?['gender'],
      birthday: data?['birthday'] != null
          ? (data?['birthday'] as Timestamp).toDate()
          : null,
      userAddress: data?['userAddress'],
      isAdmin: data?['isAdmin'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "userId": userId,
      "name": name,
      "phoneNumber": phoneNumber,
      "email": email,
      "gender": gender,
      "birthday": birthday,
      "userAddress": userAddress,
      "isAdmin": isAdmin,
    };
  }
}
