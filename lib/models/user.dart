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

  User.fromFirebaseUser(FirebaseUser user) {
    firebaseUser = user;
    uid = user.uid;
    username = user.displayName;
    email = user.email;
    level = 1;
    tasks = Tasks(Firestore.instance.collection("users").document(this.uid));
  }

// Query db
  Future<void> query() async {
  await Firestore.instance.collection("users").document(uid).get().then((result){
      print(result.data);
      uid = result.data["uid"];
      username = result.data["username"];
      email = result.data["email"];
      level = result.data["level"];
      tasks = Tasks(Firestore.instance.collection("users").document(this.uid));
      print("user stuff is set");
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
