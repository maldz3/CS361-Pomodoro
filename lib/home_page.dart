import 'package:flutter/material.dart';
import 'package:pomodoro/components/build_drawer.dart';
import 'package:pomodoro/components/app_bar.dart';
import 'package:pomodoro/models/user.dart';
import 'package:pomodoro/models/task.dart';

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
      appBar: CustomAppBar('Pomodoro Task List', user),
      drawer: BuildDrawer(user),
      body: Container(
        child: theTaskList(context),
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
    await Navigator.pushNamed(context, 'addTask', arguments: user);
    setState(() => {});
  }

  ListView theTaskList(BuildContext context) {
    final User user = this.widget.user;
    final taskList = List<Widget>();

    // determine desired sort method here, then build list according to desires

    // destructive sort alphabetical.
    user.tasks.list.sort((a, b) => a.name.compareTo(b.name));

    for (Task task in user.tasks.list) {
      taskList.add(buildTaskCard(context, task));
    }

    return ListView(children: taskList);
  }

  int toggler = 0;
  final List<Color> clrs = [Colors.blue, Colors.white];
  Widget buildTaskCard(BuildContext context, Task task) {
    toggler = 1 - toggler;
    return Container(
      decoration: taskDecoration(clrs[toggler]),
      child: Card(
        child: Column(
          children: taskContents(task),
        ),
      ),
    );
  }

  BoxDecoration taskDecoration(Color color) {
    return BoxDecoration(
      color: clrs[toggler],
    );
  }

  List<Widget> taskContents(Task task) {
    final contents = List<Widget>();

    contents.add(CheckboxListTile(
      // title
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
      value: task.selected,
      onChanged: (bool value) {
        setState(() {
          task.selected = value;
        });
      },
    ));

    // total time dedicated
    String hours = (task.totalTime ~/ 60).toString();
    String minutes = (task.totalTime % 60).toString();
    contents.add(Row(children: [
      Text('Set Work Time: ${task.durationWork}'),
      SizedBox(width: 15),
      Text('Set Break Time: ${task.durationBreak}')
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
}
