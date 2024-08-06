import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;

  Future<void> createToFirestore(DocumentReference docRef, dynamic data) async {
    try {
      print(data);
      await docRef.set(data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Object?> readFromFirestore(DocumentReference docRef) async {
    try {
      final docSnap = await docRef.get();
      final data = docSnap.data();
      if (data != null) {
        return data;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<List<Object>> readAllDocs(CollectionReference<Object> colRef) {
    try {
      final querySnap = colRef.snapshots();
      final listObjData = querySnap
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
      return listObjData;
    } catch (e) {
      throw Exception(e);
    }
  }

  void updateData(DocumentReference docRef, dynamic data) async {
    try {
      return await docRef.update(data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteData(DocumentReference docRef) async {
    try {
      await docRef.delete();
    } catch (e) {
      throw Exception(e);
    }
  }
}
