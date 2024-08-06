import 'package:e_commerce_app/app/data/models/user.dart';
import 'package:e_commerce_app/app/data/repository/firestore_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  Future<bool> registerUser(UserModel userModel, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: userModel.email, password: password);
      userModel.userId = userCredential.user?.uid ?? '';
      final registrationResult = sendDataUser(userModel);
      return registrationResult;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  String? getCurrentUserId() {
    return _auth.currentUser!.uid;
  }

  bool sendDataUser(UserModel userModel) {
    final db = FirestoreRepository();
    try {
      // Tambahkan data pengguna ke koleksi 'users' di Firestore
      db.createUser(userModel);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> userLogout() async {
    try {
      _auth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
