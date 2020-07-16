import 'package:firebase_auth/firebase_auth.dart';
import 'category.dart';
import 'task.dart';

class User {
  FirebaseUser firebaseUser;
  String uid;
  String username;
  String email;
  String password;
  int level;
  List<Task> tasks;
  List<Category> categories;

  User(String username, String email, String password) {
    this.username = username;
    this.email = email;
    this.level = 1;
    tasks = [];
    categories = [];
  }

  User.fromFirebaseUser(FirebaseUser user, String uid){
    this.firebaseUser = user;
    this.uid = uid;
  }

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
