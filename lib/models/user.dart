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
}
