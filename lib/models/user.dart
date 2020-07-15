import 'package:firebase_auth/firebase_auth.dart';
import 'category.dart';
import 'task.dart';

class User {
  String uid;
  String username;
  String email;
  String password;
  int level;
  List<Task> tasks;
  List<Category> categories;

  User(String username, String email, String password) {
    this.username = username;
    this.password = password;
    this.email = email;
    this.level = 1;
    tasks = [];
    categories = [];
  }

  User.fromFirebaseUser({this.uid});

  void addTask(Task job) {
    tasks.add(job);
  }

  void changeName(String newName) {
    username = newName;
  }

  void changeEmail(String newEmail) {
    email = newEmail;
  }

  void changePwd(String newPwd) {
    password = newPwd;
  }

}
