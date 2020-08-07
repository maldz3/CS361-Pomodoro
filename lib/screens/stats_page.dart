import 'package:flutter/material.dart';
import 'package:pomodoro/our_components.dart';
import 'package:pomodoro/our_models.dart';
import 'package:pomodoro/styles.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  List<String> userLevels = ['', 'Beginner', 'Task Master', 'Pomo Beast'];
  User user;

  @override
  void initState() {
    super.initState();
    user = User.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    int workTime, schoolTime, exerciseTime;

    for (Task t in user.tasks.list) {}

    return Scaffold(
        appBar: CustomAppBar('Stats'),
        drawer: BuildDrawer(),
        body: Builder(builder: (context) {
          return Column(children: <Widget>[
            Center(
                child: Text('Current Level: ${userLevels[user.level]}',
                    style: Styles.headerLarge)),
          ]);
        }));
  }
}
