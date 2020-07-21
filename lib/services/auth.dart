import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pomodoro/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Instantiate our custom user object from Firebase User
  User _firebaseUserToUser(FirebaseUser fbUser) {
    
    if (fbUser != null) {
      print("user instantiation attempted from _firebaseUserToUser\n");
      return User.fromFirebaseUser(fbUser);
    }
    else
      return null;
  }

  // Auth stream
  Stream<User> get userAuth {
    return _auth.onAuthStateChanged.map(_firebaseUserToUser);
  }

  //signin with email and password
  Future signIn(String email, String password) async {
    try {
      AuthResult auth_result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = auth_result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //register user
  Future register(String username, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      UserUpdateInfo updateInfo = UserUpdateInfo();
      updateInfo.displayName = username;
      user.updateProfile(updateInfo);
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //signout
  Future signOut() async {
    try {
      await _auth.signOut();      
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  FirebaseAuth get getAuth => _auth;
}
