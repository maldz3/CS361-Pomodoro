import 'package:flutter/material.dart';
import 'package:pomodoro/our_components.dart';
import 'package:pomodoro/our_models.dart';
import 'package:pomodoro/our_screens.dart';

// Logged in page

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user;

  @override
  void initState() {
    super.initState();
    user = User.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("${user.username}'s Task List"),
      drawer: BuildDrawer(),
      body: Container(
        child: TaskListView(),
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
    await Navigator.pushNamed(context, 'addTask', arguments: TaskAddPageArgs());
    setState(() => {});
  }
}

class TaskListView extends StatefulWidget {
  TaskListView();

  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  User user;
  List<Task> uTasks;

  @override
  void initState() {
    super.initState();
    user = User.getInstance();
    uTasks = new List<Task>(); // to be retrieved later.
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ListView>(
        future: theTaskList(),
        builder: (context, AsyncSnapshot<ListView> snapshot) {
          if (snapshot.hasData && uTasks.length != 0) {
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
    uTasks = await user.tasks.retrieve();

    if (uTasks.length != 0) {
      // determine desired sort method here, then build list according to desires

      // sort alphabetical.
      uTasks.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      // sort categorical
      // uTasks.sort((a, b) => a.category.toLowerCase().compareTo(b.category.toLowerCase()));

      for (Task task in uTasks) {
        taskList.add(buildTaskCard(task));
      }
    }

    return ListView(children: taskList);
  }

  Widget buildTaskCard(Task task) {
    return Container(
      // decoration:
      //     BoxDecoration(color: user.tasks.getCategory(task.category)['color']),
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
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TimerPage(task: task)),
            );
            setState(() => {});
          }),
      trailing: FlatButton(
          onPressed: () {
            editTask(task);
          },
          child: Text('Update'),
          color: user.tasks.getCategory(task.category)['color']),
      title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text(task.name,
            style: TextStyle(
                fontSize: 18.0, color: user.tasks.getCategory(task.category)['color'])),
        Container(width: 100),
        Text('Category: ${task.category}',
            style: const TextStyle(fontSize: 14.0, color: Colors.black)),
      ]),
      subtitle: new Text('Description: ${task.description}'),
    ));

    // total time dedicated
    contents.add(Row(children: [
      Text('Work Time: ${task.durationWork}'),
      SizedBox(width: 15),
      Text('Break Time: ${task.durationBreak}')
    ]));
    contents.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('Goal: ${task.goalTime} minutes'),
      SizedBox(
        width: 20,
      ),
      Text("Completed: ${task.totalTime} minutes")
    ]));

    return contents;
  }

  void editTask(Task task) async {
    await Navigator.pushNamed(context, 'addTask',
        arguments: TaskAddPageArgs(task: task));
    setState(() => {});
  }
}
