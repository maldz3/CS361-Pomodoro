class Category {
  String name;
  List<int> tasks;

  Category(String name) {
    this.name = name;
    tasks = [];
  }

  void addTask(int taskID) {
    tasks.add(taskID);
  }
}