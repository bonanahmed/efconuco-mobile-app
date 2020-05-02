import 'package:firebase_auth/firebase_auth.dart';

String errorMessage;

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> signOut() async {
    _auth.signOut();
  }

  static Future<FirebaseUser> signIn(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return firebaseUser;
    }
    catch(e){
      errorMessage = (e.toString());
      return null;
    }
  }

  static Stream<FirebaseUser> get fireBaseUserStream => _auth.onAuthStateChanged;
}
