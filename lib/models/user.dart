import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pomodoro/models/category.dart';
import 'package:pomodoro/models/task.dart';


class User {
  FirebaseUser firebaseUser;
  String uid;
  String username;
  String email;
  int level;
  Tasks tasks;
  Categories categories;
  FirebaseApp firebaseApp;
  FirebaseDatabase database;

  User.fromFirebaseUser(FirebaseUser user) {
    this.level = 1;
  }

  void logout() async {
    // I have no idea if this even works.
    if (database != null)
      await FirebaseDatabase.instance.goOffline();
    database = null;
    firebaseApp = null;    
  }

  asyncSetupShit() async {
    await connectFirebase();
    tasks = Tasks(database, uid);
    categories = Categories(database, uid);
    print('tasks was instantiated');
  }

  Future<void> connectFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    int randomToken = Random().nextInt(999999999);
    print("connecting to database with client id: " + uid + " and token " + randomToken.toString());
    firebaseApp = await FirebaseApp.configure(
        name: 'cs361-pomodoro-' + randomToken.toString(), // just made this up, AFAIK it just needs to be unique in case multiple apps are loaded.
        options: FirebaseOptions(
          clientID: uid,
          googleAppID: '1:439905512526:web:2e6e541c5b4b0c2170a71f',
          apiKey: 'AIzaSyCdc1uMGly7a7zJ_l2v8vM2cibnhpCu8bU',
          databaseURL: 'https://cs361-pomodoro.firebaseio.com',
        ));
    database = FirebaseDatabase(app: firebaseApp);
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
