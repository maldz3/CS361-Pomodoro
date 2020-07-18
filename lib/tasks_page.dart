import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'dart:developer'; // for debug printing with "log"
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro/components/build_drawer.dart';
import 'package:pomodoro/components/app_bar.dart';
import 'package:pomodoro/models/task.dart';
import 'package:pomodoro/models/user.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class FuckEverything {
  String kmn;
  FuckEverything(this.kmn);
}

class _TasksPageState extends State<TasksPage> {
  final List<ListItem> tasksList = List<ListItem>();
  Task task = Task(name: "Task Name", durationWork: 10, durationBreak: 10, totalTime: 0, goalTime: 60);
  User user;
  //DatabaseReference taskRef;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // this wasn't working for some reason
    // user = Provider.of<User>(context);
    // task = Task(name: "Task Name", durationWork: 10, durationBreak: 10, totalTime: 0, goalTime: 60);

    // final FirebaseDatabase database = FirebaseDatabase.instance; //Rather then just writing FirebaseDatabase(), get the instance.  
    // taskRef = database.reference().child('items');
    // taskRef.onChildAdded.listen(_onEntryAdded);
    // taskRef.onChildChanged.listen(_onEntryChanged);

      String dumpsterFire = "testinsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfg";
  
  var wastedLife = FuckEverything(dumpsterFire);
  
  print(wastedLife.kmn);
  
  dumpsterFire = "never going to get that time back";
  
  print(wastedLife.kmn);
  }
  

  @override
  Widget build(BuildContext context) {
    // had to move this here from initstate because the shit wasn't working there.
    user = Provider.of<User>(context);

    // fill tasks list
    fillTasks();

    return Scaffold(
        appBar: CustomAppBar('Tasks'),
        drawer: BuildDrawer(),

        resizeToAvoidBottomPadding: false,

        body: Column(children: <Widget>[ inputForm(), tasksListing(tasksList)],));
  }

  void fillTasks(){
    // here, ordering and categorization would occur
    tasksList.clear(); // clear old list
    tasksList.add(CategoryItem("Uncategorized"));
    log('this far');
    for (task in user.tasks.list)
    {
      log("task being added, task name: " + task.name);
      tasksList.add(TaskItem(task.name.toString()));
    }
  }


  Widget inputForm(){
    return Flexible(
            flex: 0,
            child: Center(
              child: Form(
                key: formKey,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    ListTile(
                      leading: Text("Enter task name:"),
                      title: TextFormField(
                        initialValue: "",
                        onSaved: (val) => task.name = val,
                        validator: (val) => val == "" ? val : null,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () {
                        handleSubmit();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  void handleSubmit() {
    final FormState form = formKey.currentState;
    log('!!!!!!!!!!!!!! handling task submission.');
    if (form.validate()) {
      form.save();
      form.reset();
      log('form page adding task with name: ' + task.name);
      user.tasks.add(task);
      
      //fillTasks();
      //taskRef.push().set(task.toJson());
    }

    setState(() {});
  }

  Widget tasksListing(items) {
    return Flexible(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                return ListTile(
                  title: item.buildTitle(context),
                  subtitle: item.buildSubtitle(context),
                );
              },
            ),
          );
  }
}

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

class CategoryItem implements ListItem {
  final String category;

  CategoryItem(this.category);

  Widget buildTitle(BuildContext context) {
    return Text(
      category,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  Widget buildSubtitle(BuildContext context) => null;
}

class TaskItem implements ListItem {
  final String name;

  TaskItem(this.name);

  Widget buildTitle(BuildContext context) => Text(name);

  Widget buildSubtitle(BuildContext context) => Text("details here");
}