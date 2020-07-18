class Category {
  String key;
  String name;
  List<String> tasks;

  Category(String name) {
    this.name = name;
    tasks = [];
  }

  void addTask(String taskKey) {
    tasks.add(taskKey);
  }

}