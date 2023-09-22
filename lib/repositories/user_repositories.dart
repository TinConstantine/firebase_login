import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepositories {
  FirebaseAuth? _firebaseAuth;
  GoogleSignIn? _googleSignIn;
  UserRepositories({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn}) {
    _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
    _googleSignIn = googleSignIn ?? GoogleSignIn();
  }
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth!
        .signInWithEmailAndPassword(email: email.trim(), password: password);
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth!.createUserWithEmailAndPassword(
        email: email.trim(), password: password);
  }

  Future<void> signOut() async {
    await Future.wait([
      _firebaseAuth!.signOut(),
      _googleSignIn!.signOut(),
    ]);
  }

  // bool isSignedIn() {
  //   // ignore: unrelated_type_equality_checks
  //   return _firebaseAuth!.currentUser != Null;
  // }
  bool isSignedIn() {
    final user = _firebaseAuth!.currentUser;
    return user != null;
  }

  // User? getUser() {
  //   return _firebaseAuth!.currentUser;
  // }
  User? getUser() {
    print('_firebaseAuth?.currentUser: $_firebaseAuth?.currentUser');
    return _firebaseAuth!.currentUser;
  }

  Future<void> signInWithGoogle() async {
    final googleSignInAccount = await _googleSignIn!.signIn();
    final googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);
    await _firebaseAuth!.signInWithCredential(authCredential);
  }
}
