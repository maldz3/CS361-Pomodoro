import 'package:flutter/material.dart';
import 'package:pomodoro/components/build_drawer.dart';
import 'package:pomodoro/components/app_bar.dart';
import 'package:pomodoro/models/user.dart';
import 'package:pomodoro/models/task.dart';
import 'package:pomodoro/tasks_page.dart';

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
        appBar: CustomAppBar('Add a Task'),
        //drawer: buildDrawer,
        body: TasksAddForm(user, buildDrawer),
      ),
    );
  }
}

class TasksAddForm extends StatefulWidget {
  final User user;
  final BuildDrawer buildDrawer;
  TasksAddForm(this.user, this.buildDrawer);

  @override
  _TasksAddFormState createState() => _TasksAddFormState();
}

class _TasksAddFormState extends State<TasksAddForm> {
  final taskNameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    taskNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: taskNameController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: submit,
        tooltip: 'Submit',
        child: Icon(Icons.text_fields),
      ),
    );
  }

  void submit() {
    User user = this.widget.user;
    Task newTask = Task(name: taskNameController.text);

    user.tasks.add(newTask);

    Navigator.popUntil(context, ModalRoute.withName('/'));
    Navigator.push(context, MaterialPageRoute(
                      settings: RouteSettings(name: "/tasksPage"),
                      builder: (context) => TasksPage(user, widget.buildDrawer)));
    //Navigator.pushNamed(context, '/');
  }
}