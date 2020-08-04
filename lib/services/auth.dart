import 'package:firebase_auth/firebase_auth.dart';
import 'package:pomodoro/our_models.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //signin with email and password
  Future<FirebaseUser> signIn(String email, String password) async {
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = authResult.user;
      User.initialize(user);
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //register user
  Future<FirebaseUser> register(String username, String email, String password) async {
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
  Future<void> signOut() async {
    try {
      await _auth.signOut();      
    } catch (error) {
      print(error.toString());
    }
    User.dispose();
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  FirebaseAuth get getAuth => _auth;
}
