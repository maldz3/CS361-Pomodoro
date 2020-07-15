import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Instantiate our custom user object from Firebase User
  User _firebaseUserToUser(FirebaseUser user) {
    return user != null ? User.fromFirebaseUser(
      uid: user.uid) : null;
  }

  // Auth stream
  Stream<User> get userAuth {
    return _auth.onAuthStateChanged.map(_firebaseUserToUser);
  }

  //TODO: signin with email and password
  Future signIn(String email, String password) async {
    try {
      AuthResult auth_result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = auth_result.user;
      return _firebaseUserToUser(user);
    } catch(error) {
      print(error.toString());
      return null;
    }
  }

  //TODO:register user
  
  //TODO: signout 
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(error) {
      print(error.toString());
      return null;
    }
  }

}





