import 'package:firebase_auth/firebase_auth.dart';
import 'category.dart';
import 'task.dart';

class User {
  FirebaseUser firebaseUser;
  String uid;
  String username;
  int level;
  List<Task> tasks;
  List<Category> categories;

  User.fromFirebaseUser(FirebaseUser user){
    this.firebaseUser = user;
    this.uid = user.uid;
    this.level = 1;
    this.tasks = [];
    this.categories = [];
  }

  String get userEmail => firebaseUser.email;

  String get userName => username;

  void addTask(Task job) {
    tasks.add(job);
  }

  void changeName(String newName) {
    username = newName;
  }

  set changeEmail(String newEmail) {
    firebaseUser.updateEmail(newEmail);
  }


}
