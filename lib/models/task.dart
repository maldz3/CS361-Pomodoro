import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Tasks {
  DocumentReference _document;
  var uuid = Uuid();
  List<Task> _innerList = List<Task>();

  final categories = [
    {'id': 'School', 'value': 'School', 'color': Colors.tealAccent},
    {'id': 'Work', 'value': 'Work', 'color': Colors.deepOrangeAccent},
    {'id': 'Exercise', 'value': 'Exercise', 'color': Colors.blueAccent},
    {'id': 'Home', 'value': 'Home', 'color': Colors.purpleAccent},
    {'id': 'Family', 'value': 'Family', 'color': Colors.deepPurple},
    {'id': 'Other', 'value': 'Other', 'color': Colors.green},
  ];

  Tasks(DocumentReference document): _document = document;

  Map<String, dynamic> getCategory(String categoryName) {
    for (int i = 0; i < categories.length; i++) {
      if (categories[i]['value'] == categoryName)
        return categories[i];
    }
    return categories[0]; // for lack of a better idea.
  }

  int get length {
    return _innerList.length;
  }

  List<Task> get list => _innerList;

  Future<void> update(Task task) {
    assert(task != null && task.id != null);
    add(task);
  }

  Future<void> add(Task taskToCopy) {
    Task task = Task.fromTask(taskToCopy);

    // if task does not have an ID, it's new so stamp with ID and add to internal list
    if (task.id == 'null' || task.id == '' || task.id == null) {
      String uniqueID = uuid.v1();
      print('generated unique id: ' + uniqueID);
      task.id = uniqueID; // apply a unique time based id to the task.

      // add task to inner list
      _innerList.add(task);
    }
    else { // task has an ID, so it should match one already, add if not
      bool foundMatch = false;
      for(Task t in _innerList) {
        if (t.id == task.id) {
          foundMatch = true;
          break;
        }
      }
      if (!foundMatch) {
        // add task to inner list
        _innerList.add(task);
      }
    }

    // add task to database; will update if task with key exists.
    return _document.setData({'tasks': task.toJson()}, merge: true);
  }

  Future<List<Task>> retrieve() async {
    final newList = List<Task>();

    // get new tasks (wasteful, but ok for this app in the sake of brevity)
    var result = await _document.get();
    if (result.data['tasks'] != null)
      result.data['tasks'].forEach((key, value) {
        newList.add(Task.fromJson(key, value));
    });
    _innerList = newList;
    return _innerList;
  }
}

class Task {
  String id;
  bool selected = false;
  String name = 'task name';
  String description;
  int durationWork = 20;
  int durationBreak = 10;
  int totalTime = 0;
  int goalTime = 60;
  String category = 'category';

  Task(
      {
        String id,
        String name,
        String description,
        int durationWork,
        int durationBreak,
        int totalTime,
        int goalTime,
        String category}) {
    //
    this.id = id;
    this.name = name.toString();
    this.description = description.toString();
    this.durationWork = durationWork;
    this.durationBreak = durationBreak;
    this.totalTime = totalTime;
    this.goalTime = goalTime;
    this.category = category; //
  }

  Task.fromTask(Task t) {
    id = t.id.toString();
    name = t.name.toString();
    description = t.description.toString();
    durationWork = t.durationWork;
    durationBreak = t.durationBreak;
    totalTime = t.totalTime;
    goalTime = t.goalTime;
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
    //print('creating task with json: ' + json.toString());
    id = key;
    name = json['name'];
    description = json['description'];
    durationWork = json['durationWork'];
    durationBreak = json['durationBreak'];
    totalTime = json['totalTime'];
    goalTime = json['goalTime'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['durationWork'] = this.durationWork;
    data['durationBreak'] = this.durationBreak;
    data['totalTime'] = this.totalTime;
    data['goalTime'] = this.goalTime;
    data['category'] = this.category;

    final Map<String, dynamic> theTask = new Map<String, dynamic>();
    theTask[this.id] = data;

    return theTask;
  }
}
