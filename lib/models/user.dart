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

}
