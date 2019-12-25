import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthConfig {
  final FirebaseAuth _auth = FirebaseAuth.instance;

   //firebase
  Stream get user {
    return _auth.onAuthStateChanged;
  }

  //firebase
  Future registerWithEmailAndPassword(String email, String password) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email , password: password);
    return result;
  }

  //firebase
  Future signout() async {
    return _auth.signOut();
  }
}