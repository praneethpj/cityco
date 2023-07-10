import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  //registration method
  Future<void> signUp() async {
    try {
      FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
