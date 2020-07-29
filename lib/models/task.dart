import 'dart:developer'; // for debug printing with "log"
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Tasks {
  DocumentReference _document;
  var uuid = Uuid();
  final List<Task> _innerList = List<Task>();

  final categories = [
    {'id': 'School', 'value': 'School'},
    {'id': 'Work', 'value': 'Work'},
    {'id': 'Exercise', 'value': 'Exercise'},
    {'id': 'Home', 'value': 'Home'},
    {'id': 'Family', 'value': 'Family'},
    {'id': 'Other', 'value': 'Other'}
  ];

  Tasks(DocumentReference document): _document = document;

  int getCategoryIndex(String categoryName) {
    print('looking for:');
    print(categoryName);
    for (int i = 0; i < categories.length; i++) {
      print(categories[i]['value']);
      if (categories[i]['value'] == categoryName)
        return i;
    }
    return -1;
  }

  int get length {
    return _innerList.length;
  }

  List<Task> get list => _innerList;

  Future<void> add(Task taskToCopy) {
    Task task = Task.fromTask(taskToCopy);
    if (task.id == 'null' || task.id == '' || task.id == null) {
      String uniqueID = uuid.v1();
      print('generated unique id: ' + uniqueID);
      task.id = uniqueID; // apply a unique time based id to the task.
  }

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
    log('adding task now with key: ' + key);
    _innerList.add(Task.fromJson(key, value));
    });
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
        int totalTime = 0,
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
    log('creating task with json: ' + json.toString());
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
