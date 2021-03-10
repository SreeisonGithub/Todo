
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  AuthenticationService();
  

  Stream<User> get authStateChanges =>FirebaseAuth.instance.authStateChanges();



  Future<String> signIn(String email, String password,) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      return 'Signed In';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }


  Future<String> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Signed up';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  
   User getCurrentFirebaseUser()  {
    User currentUser =  FirebaseAuth.instance.currentUser;
    return currentUser;
  }

  Future<void> signOut() async {
    
   await FirebaseAuth.instance.signOut();
  }

   Future<void> forgotPasswordEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

}
