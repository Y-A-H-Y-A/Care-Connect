import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AthenticationService {
  final FirebaseAuth _firbaseAuth;
  AthenticationService(this._firbaseAuth);

  Stream<User?> get authStateChanges => _firbaseAuth.authStateChanges();

  Future<String?> login(
      {required String email, required String password}) async {
    try {
      await _firbaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'Signed In';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signup(
      {required String email, required String password}) async {
    try {
      await _firbaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Signed Up';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    await _firbaseAuth.signOut();
  }
}
