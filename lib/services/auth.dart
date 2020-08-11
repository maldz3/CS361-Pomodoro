import 'package:firebase_auth/firebase_auth.dart';
import 'package:pomodoro/our_models.dart';

class AuthService {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<FirebaseUser> getFirebaseUser() async {
    FirebaseUser firebaseUser = await auth.currentUser();
    if (firebaseUser == null) {
      firebaseUser = await FirebaseAuth.instance.onAuthStateChanged.first;
    }
    return firebaseUser;
  }

  //signin with email and password
  static Future<FirebaseUser> signIn(String email, String password) async {
    try {
      AuthResult authResult = await auth.signInWithEmailAndPassword(
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
  static Future<FirebaseUser> register(
      String username, String email, String password) async {
    try {
      AuthResult result = await auth.createUserWithEmailAndPassword(
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
  static Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (error) {
      print(error.toString());
    }
    User.dispose();
  }

  static Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }
}
