import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:developer'; // for debug printing with "log"


class Tasks {
  final List<Task> _innerList = List<Task>();

  int get length {
    return _innerList.length;
  }

  List<Task> get list => _innerList;


  add(Task taskToCopy) {
    
    Task task = Task.fromTask(taskToCopy);
    /*
    // add task to database
    DatabaseReference insertionRef = tasksRef.push();
    insertionRef.set(task.toJson());
    task.key = insertionRef.key;
    */
    // add task to inner list
    _innerList.add(task);
  }

  /*
  retrieve() {
    log('retrieving tasks...');
    
    tasksRef.once().then((DataSnapshot snapshot) {
       Map<dynamic,dynamic> map = snapshot.value;
       log('existing user tasks: ' + map.toString());
       map.forEach((key, value) {
         log('adding task now with name: ' + value['name']);
         _innerList.add(Task.fromJson(key, value));
         });
    });
  }
  */

  void fromSnapshot(DataSnapshot snapshot) {
    // for every task in snapshot, create task and add to list
  }
}

class Task {
  bool selected = false;
  String key = 'unset_task_key';
  String name = 'task name';
  int durationWork = 20;
  int durationBreak = 10;
  int totalTime = 0;
  int goalTime = 60;
  String categoryKey = 'unset_task_category_key';

  Task({String name, int durationWork = 20, int durationBreak = 10, int totalTime = 0,
      int goalTime = 60}) {
    this.name = name.toString();
    this.durationWork = durationWork;
    this.durationBreak = durationBreak;
    this.totalTime = totalTime;
    this.goalTime = goalTime;
  }

  Task.fromTask(Task t) {
    key = t.key.toString();
    name = t.name.toString();
    durationWork = t.durationWork;
    durationBreak = t.durationBreak;
    totalTime = t.totalTime;
    goalTime = t.goalTime;
    categoryKey = t.categoryKey.toString();
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

  Task.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        name = snapshot.value["name"],
        durationWork = snapshot.value["durationWork"],
        durationBreak = snapshot.value["durationBreak"],
        totalTime = snapshot.value["totalTime"],
        goalTime = snapshot.value["goalTime"],
        categoryKey = snapshot.value["categoryKey"];

  Task.fromJson(String key, Map<dynamic, dynamic> json) {
    log('creating task with json: ' + json.toString());
    key = key;
    name = json['name'];
    durationWork = json['durationWork'];
    durationBreak = json['durationBreak'];
    totalTime = json['totalTime'];
    goalTime = json['goalTime'];
    categoryKey = json['categoryKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['durationWork'] = this.durationWork;
    data['durationBreak'] = this.durationBreak;
    data['totalTime'] = this.totalTime;
    data['goalTime'] = this.goalTime;
    data['categoryKey'] = this.categoryKey;
    return data;
  }
}
