import 'package:firebase_auth/firebase_auth.dart';
import 'category.dart';
import 'task.dart';

class User {
  FirebaseUser firebaseUser;
  String uid;
  String username;
  String email;
  int level;
  List<Task> tasks;
  List<Category> categories;

  User.fromFirebaseUser(FirebaseUser user) {
    this.firebaseUser = user;
    this.username = firebaseUser.displayName;
    this.email = firebaseUser.email;
    this.uid = user.uid;
    this.level = 1;
    this.tasks = [];
    this.categories = [];
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
