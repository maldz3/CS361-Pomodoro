import 'package:flutter/material.dart';
import 'package:pomodoro/our_components.dart';
import 'package:pomodoro/our_models.dart';
import 'package:pomodoro/tasks_add_page.dart';
import 'package:pomodoro/timer_page.dart';

// Logged in page

class HomePage extends StatefulWidget {
  final User user;

  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User user = this.widget.user;

    return Scaffold(
      appBar: CustomAppBar("${user.username}'s Task List", user),
      drawer: BuildDrawer(user),
      body: Container(
        child: TaskListView(user),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTask(user);
        },
        child: Icon(Icons.playlist_add),
        backgroundColor: Colors.green,
      ),
    );
  }

  void addTask(User user) async {
    await Navigator.pushNamed(context, 'addTask',
        arguments: TaskAddPageArgs(user));
    setState(() => {});
  }
}

class TaskListView extends StatefulWidget {
  final User user;

  TaskListView(this.user);

  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ListView>(
        future: theTaskList(),
        builder: (context, AsyncSnapshot<ListView> snapshot) {
          if (snapshot.hasData) {
            print('done getting data');
            return snapshot.data;
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ListView(
              children: [Center(child: Text("Please add a task."))],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Future<ListView> theTaskList() async {
    final taskList = List<Widget>();
    final User user = this.widget.user;
    List<Task> uTasks = await user.tasks.retrieve();

    // determine desired sort method here, then build list according to desires

    // sort alphabetical.
    uTasks.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    // sort categorical
    // uTasks.sort((a, b) => a.category.toLowerCase().compareTo(b.category.toLowerCase()));

    for (Task task in uTasks) {
      taskList.add(buildTaskCard(task));
    }

    return ListView(children: taskList);
  }

  Widget buildTaskCard(Task task) {
    return Container(
      decoration: BoxDecoration(
          color: this.widget.user.tasks.getCategory(task.category)['color']),
      child: Card(
        child: Column(
          children: taskContents(task),
        ),
      ),
    );
  }

  List<Widget> taskContents(Task task) {
    final contents = List<Widget>();

    contents.add(ListTile(
      // title
      leading: FlatButton(
          child: Icon(Icons.play_arrow),
          color: Colors.green,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    TimerPage(user: this.widget.user, task: task)));
          }),
      trailing: FlatButton(
          onPressed: () {
            editTask(task);
          },
          child: Text('Update'),
          color: this.widget.user.tasks.getCategory(task.category)['color']),
      title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text(task.name,
            style: const TextStyle(
                fontSize: 18.0, color: Colors.deepPurpleAccent)),
        Container(width: 100),
        Text('Category: ${task.category}',
            style: const TextStyle(fontSize: 14.0, color: Colors.black)),
      ]),
      // category
      //subtitle: new Text("category"),//user.categories[task.categoryKey].name),
      subtitle: new Text('Description: ${task.description}'),
    ));

    // total time dedicated
    String hours = (task.totalTime ~/ 60).toString();
    String minutes = (task.totalTime % 60).toString();
    contents.add(Row(children: [
      Text('Work Time: ${task.durationWork}'),
      SizedBox(width: 15),
      Text('Break Time: ${task.durationBreak}')
    ]));
    contents.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('Goal: ${task.goalTime}'),
      SizedBox(
        width: 20,
      ),
      Text("Dedicated: " + hours + " hours, " + minutes + " minutes.")
    ]));

    return contents;
  }

  void editTask(Task task) async {
    await Navigator.pushNamed(context, 'addTask',
        arguments: TaskAddPageArgs(this.widget.user, task: task));
    setState(() => {});
  }
}
