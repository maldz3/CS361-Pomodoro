import 'category.dart';
import 'task.dart';

class User {
  int id;
  String username;
  String email;
  String password;
  int level;
  List<Task> tasks;
  List<Category> categories;

  User(String username, String email, String password) {
    this.username = username;
    this.email = email;
    this.password = password;
    this.level = 1;
    tasks = [];
    categories = [];
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
