import 'dart:developer'; // for debug printing with "log"
import 'package:cloud_firestore/cloud_firestore.dart';

class Tasks {
  DocumentReference _document;
  final List<Task> _innerList = List<Task>();

  Tasks(DocumentReference document): _document = document;

  int get length {
    return _innerList.length;
  }

  List<Task> get list => _innerList;

  Future<void> add(Task taskToCopy) {
    Task task = Task.fromTask(taskToCopy);

    // add task to inner list
    _innerList.add(task);

    // add task to database
    return _document.setData({'tasks': task.toJson()}, merge: true);
  }

  Future<List<Task>> retrieve() async {
    // dump existing tasks
    _innerList.clear();

    // get new tasks (wasteful, but ok for this app in the sake of brevity)
    var result = await _document.get();
    print(result.documentID);
    print(result.data['tasks'].toString());
    result.data['tasks'].forEach((key, value) {
    log('adding task now with name: ' + key);
    _innerList.add(Task.fromJson(key, value));
    });
    return _innerList;
  }
}

class Task {
  bool selected = false;
  String name = 'task name';
  String description;
  int durationWork = 20;
  int durationBreak = 10;
  int totalTime = 0;
  int goalTime = 60;
  String categoryKey = 'unset_task_category_key';
  String category = 'category';

  Task(
      {String name,
        String description,
        int durationWork,
        int durationBreak,
        int totalTime = 0,
        int goalTime,
        String category}) {
    //
    this.name = name.toString();
    this.description = description.toString();
    this.durationWork = durationWork;
    this.durationBreak = durationBreak;
    this.totalTime = totalTime;
    this.goalTime = goalTime;
    this.category = category; //
  }

  Task.fromTask(Task t) {
    name = t.name.toString();
    description = t.description.toString();
    durationWork = t.durationWork;
    durationBreak = t.durationBreak;
    totalTime = t.totalTime;
    goalTime = t.goalTime;
    categoryKey = t.categoryKey.toString();
    category = t.category.toString(); //
  }

  void addTime(int newTime) {
    totalTime += newTime;
  }

  void changeWorkTime(int newTime) {
    durationWork = newTime;
  }

  void changeBreakTime(int newTime) {
    durationBreak = newTime;
  }

  Task.fromJson(String key, Map<dynamic, dynamic> json) {
    log('creating task with json: ' + json.toString());
    //name = json['name'];
    name = key;
    description = json['description'];
    durationWork = json['durationWork'];
    durationBreak = json['durationBreak'];
    totalTime = json['totalTime'];
    goalTime = json['goalTime'];
    categoryKey = json['categoryKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['durationWork'] = this.durationWork;
    data['durationBreak'] = this.durationBreak;
    data['totalTime'] = this.totalTime;
    data['goalTime'] = this.goalTime;
    data['categoryKey'] = this.categoryKey;

    final Map<String, dynamic> theTask = new Map<String, dynamic>();
    theTask[this.name] = data;

    return theTask;
  }
}
