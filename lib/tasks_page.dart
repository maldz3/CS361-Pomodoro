import 'dart:developer'; // for debug printing with "log"
import 'package:flutter/material.dart';
import 'package:pomodoro/components/build_drawer.dart';
import 'package:pomodoro/components/app_bar.dart';
import 'package:pomodoro/models/task.dart';
import 'package:pomodoro/models/user.dart';

class TasksPage extends StatefulWidget {
  User user;

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    this.widget.user = ModalRoute.of(context).settings.arguments;
    User user = this.widget.user;

    log("building tasks page");
    return Scaffold(
        appBar: CustomAppBar('Tasks', user),
        drawer: BuildDrawer(user),
        body: Container (
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

  void addTask (User user) async {
    await Navigator.pushNamed(context, 'addTask', arguments: user);
    setState(() => {});
  }

  ListView theTaskList(BuildContext context) {
    final User user = this.widget.user;
    final taskList = List<Widget>();

    // determine desired sort method here, then build list according to desires

    // destructive sort alphabetical.
    user.tasks.list.sort((a, b) => a.name.compareTo(b.name));

    for (Task task in user.tasks.list){
      taskList.add(buildTaskCard(context, task));
    }

    return ListView(children: taskList);
  }

  int toggler = 0;
  final List<Color> clrs = [Colors.blue, Colors.white];
  Widget buildTaskCard(BuildContext context, Task task) {
    toggler = 1 - toggler;
    return Container(
                //margin: const EdgeInsets.all(15.0),
                //padding: const EdgeInsets.all(1.0),
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
      // border: Border.all(
      //   width: 1,
      // ),
    );
  }

  List<Widget> taskContents(Task task) {
    final contents = List<Widget>();

    contents.add(
      CheckboxListTile(
                // title
                title: new Text(
                  task.name,
                  style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                // category
                //subtitle: new Text("category"),//user.categories[task.categoryKey].name),
                subtitle: new Text("${task.category}"),
                value: task.selected,
                onChanged: (bool value) {
                setState(() {
                  task.selected = value;
                });
              },
              )
              );

    // total time dedicated
    String hours = (task.totalTime ~/ 60).toString();
    String minutes = (task.totalTime % 60).toString();
    contents.add(Text("Dedicated: " + hours + " hours, " + minutes + " minutes."));

    return contents;
  }
}


// class TasksPage extends StatelessWidget {
//   final User user;
//   final BuildDrawer buildDrawer;
//   TasksPage(this.user, this.buildDrawer);

//   @override
//   Widget build(BuildContext context) {
//     log("building tasks page");
//     return Scaffold(
//         appBar: CustomAppBar('Timer'),
//         drawer: buildDrawer,
//         body: Container (
//             child: theTaskList(context),
//           ),
//         floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context) => TasksAddPage(user, buildDrawer)));
//         },
//         child: Icon(Icons.playlist_add),
//         backgroundColor: Colors.green,
//       ),
//         );
//   }

//   ListView theTaskList(BuildContext context) {
//     final taskList = List<Widget>();

//     // determine desired sort method here, then build list according to desires

//     // destructive sort alphabetical.
//     user.tasks.list.sort((a, b) => a.name.compareTo(b.name));

//     for (Task task in user.tasks.list){
//       taskList.add(buildTaskCard(context, task));
//     }

//     return ListView(children: taskList);
//   }

//   int toggler = 0;
//   final List<Color> clrs = [Colors.blue, Colors.white];
//   Widget buildTaskCard(BuildContext context, Task task) {
//     toggler = 1 - toggler;
//     return Container(
//                 //margin: const EdgeInsets.all(15.0),
//                 //padding: const EdgeInsets.all(1.0),
//                 decoration: taskDecoration(clrs[toggler]),
//                 child: Card(
//                   child: Column(
//                     children: taskContents(task),
//                   ),
//                 ),
//               );
//   }

//   BoxDecoration taskDecoration(Color color) {
//     return BoxDecoration(
//       color: clrs[toggler],
//       // border: Border.all(
//       //   width: 1,
//       // ),
//     );
//   }

//   List<Widget> taskContents(Task task) {
//     final contents = List<Widget>();

//     contents.add(
//       ListTile(
//                 // title
//                 title: new Text(
//                   task.name,
//                   style: const TextStyle(
//                       fontSize: 18.0,
//                       color: Colors.deepPurpleAccent,
//                     ),
//                   ),
//                 // category
//                 subtitle: new Text("category"),//user.categories[task.categoryKey].name),
//               )
//               );

//     // total time dedicated
//     String hours = (task.totalTime ~/ 60).toString();
//     String minutes = (task.totalTime % 60).toString();
//     contents.add(Text("Dedicated: " + hours + " hours, " + minutes + " minutes."));

//     return contents;
//   }
// }