import 'package:firebase_auth/firebase_auth.dart';
import 'package:pomodoro/our_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class User {
  FirebaseUser firebaseUser;
  String uid;
  String username;
  String email;
  int level;
  Tasks tasks;

  static User _instance;

  User._();

  factory User.getInstance() {
    //assert(_instance != null); // allow null return so that we can check if initialized.
    return _instance;
  }

  static void initialize(FirebaseUser user) {
    String action = _instance == null ? "initialized" : "re-initialized";
    print('User has been ' + action);
    _instance = User._();
    _instance.firebaseUser = user;
    _instance.uid = user.uid;
    _instance.username = user.displayName;
    _instance.email = user.email;
    _instance.level = 1;
    _instance.tasks = Tasks(Firestore.instance.collection("users").document(_instance.uid));
  }

  void assignFromFirebaseUser(FirebaseUser user) {
    firebaseUser = user;
    uid = user.uid;
    username = user.displayName;
    email = user.email;
    level = 1;
    tasks = Tasks(Firestore.instance.collection("users").document(this.uid));
  }

  static void initDBEntry(String uid, String username, String email) async {
    Firestore db = Firestore.instance;
      await db
          .collection("users")
          .document(uid)
          .setData({
      "uid": uid,
      "username": username,
      "email": email
      });
  }

  String getName() {
    return firebaseUser.displayName;
  }

  String getEmail() {
    return firebaseUser.email;
  }

  void addTask(Task job) {
    tasks.add(job);
  }

  Future<bool> changeName(String newName) async {

    //store original value in case of error
    String currentUsername = firebaseUser.displayName;

    // update in firebase
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = newName;
    try {
      await dbUpdate("username", newName);
      await firebaseUser.updateProfile(updateInfo);
      username = newName;
      return true;
    // error catcher
    } catch (err) {
      dbUpdate("username", currentUsername);
      print(err);
      return false;
    }
  }

  Future<bool> changeEmail(String newEmail) async {

    //store current value in case of failure
    String currentEmail = firebaseUser.email;

    try {
      // update in firebase
      await dbUpdate("email", newEmail);
      await firebaseUser.updateEmail(newEmail);
      email = newEmail;
      return true;
    // error catcher
    } catch (err) {
      await dbUpdate("email", currentEmail);
      print(err);
      return false;
    }
  }

  Future dbUpdate(String field, String fieldValue) async {
    try {
    // Update passed in field in database
      Firestore db = Firestore.instance;
      await db.collection("users").document(this.uid).updateData({field: fieldValue});
      print("db update success");
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<bool> changePassword(String newPassword) async {
    try {
      await firebaseUser.updatePassword(newPassword);
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }
}
