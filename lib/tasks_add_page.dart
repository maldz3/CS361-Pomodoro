import 'package:flutter/material.dart';
import 'package:pomodoro/components/build_drawer.dart';
import 'package:pomodoro/components/app_bar.dart';
import 'package:pomodoro/models/user.dart';
import 'package:pomodoro/models/task.dart';

/*
class TasksAddPage extends StatelessWidget {
  final User user;
  final BuildDrawer buildDrawer;
  TasksAddPage(this.user, this.buildDrawer);


  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: CustomAppBar('Add a Task', user),
        //drawer: buildDrawer,
        body: TasksAddForm(user, buildDrawer),
      ),
    );
  }
}
*/

class TasksAddPage extends StatefulWidget {
  final User user;
  final BuildDrawer buildDrawer;
  TasksAddPage(this.user, this.buildDrawer);

  @override
  _TasksAddPageState createState() => _TasksAddPageState();
}

class _TasksAddPageState extends State<TasksAddPage> {
  final taskNameController = TextEditingController();
  final taskDurationWorkController = TextEditingController();
  final taskDurationBreakController = TextEditingController();
  final taskGoalTimeController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    taskNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Add a Task', this.widget.user),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextFormField(
                controller: taskNameController,
                autofocus: false,
                decoration: InputDecoration(
                    labelText: 'Task Name',
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
          TextFormField(
                controller: taskDurationWorkController,
                autofocus: false,
                decoration: InputDecoration(
                    labelText: 'Work Time Per Interval (Minutes)',
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
        TextFormField(
                controller: taskDurationBreakController,
                autofocus: false,
                decoration: InputDecoration(
                    labelText: 'Break Time Per Interval (Minutes)',
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
        TextFormField(
                controller: taskGoalTimeController,
                autofocus: false,
                decoration: InputDecoration(
                    labelText: 'Goal (Minutes)',
                    border: OutlineInputBorder()),
              ),
        ],)
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: submit,
        tooltip: 'Submit',
        child: Icon(Icons.save),
      ),
    );
  }

  void submit() {
    User user = this.widget.user;
    Task newTask = Task(name: taskNameController.text);

    user.tasks.add(newTask);

    Navigator.of(context).pop();
    // Navigator.popUntil(context, ModalRoute.withName('/'));
    // Navigator.push(context, MaterialPageRoute(
    //                   settings: RouteSettings(name: "/tasksPage"),
    //                   builder: (context) => TasksPage(user, widget.buildDrawer)));
  }
}