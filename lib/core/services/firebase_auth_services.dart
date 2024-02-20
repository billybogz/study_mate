import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  get user => _firebaseAuth.currentUser;
  get isAuthenticated => _firebaseAuth.currentUser != null;

  static Future<User> signUp({
    required String email,
    required String password,
  }) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final User user = result.user!;
    return user;
  }

  static Future<User> logIn({
    required String email,
    required String password,
  }) async {
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final User user = result.user!;
    return user;
  }

  static Future<void> signOut() async => await _firebaseAuth.signOut();
}
