import 'package:firebase_auth/firebase_auth.dart';
import 'package:pomodoro/models/category.dart';
import 'package:pomodoro/models/task.dart';
import 'dart:developer'; // for debug printing with "log"
import 'package:cloud_firestore/cloud_firestore.dart';


class User {
  FirebaseUser firebaseUser;
  String uid;
  String username;
  String email;
  int level;
  Tasks tasks;
  Categories categories;

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

  void changeName(String newName) {
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = newName;
    firebaseUser.updateProfile(updateInfo);
    username = newName;
  }

  void changeEmail(String newEmail) {
    firebaseUser.updateEmail(newEmail);
    email = newEmail;
  }

  void changePassword(String newPassword) {
    firebaseUser.updatePassword(newPassword);
  }
}
