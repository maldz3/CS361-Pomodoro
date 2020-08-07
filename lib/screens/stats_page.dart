import 'package:flutter/material.dart';
import 'package:pomodoro/our_components.dart';
import 'package:pomodoro/our_models.dart';
import 'package:pomodoro/styles.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  List<String> userLevels = ['', 'Beginner', 'Task Rabbit', 'Task Master', 'Pomo Beast'];
  User user;
  int total_time = 0;

  @override
  void initState() {
    super.initState();
    user = User.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    int workTime, schoolTime, exerciseTime, homeTime, familyTime, otherTime;

    Map<String, int> catTimes = { 'Home': 0, 'Work': 0, 'Exercise': 0, 'Family': 0, 'Other': 0 };

    if(user != null && user.tasks.list != null) {
      for (Task t in user.tasks.list) {
        String category = t.category.toString();
        if (t.totalTime > 0) {
          catTimes[category] += t.totalTime;
        }
      }
    }

    catTimes.forEach((k,v) => total_time += v);
    print(total_time);

    return Scaffold(
        appBar: CustomAppBar('Stats'),
        drawer: BuildDrawer(),
        body: Builder(builder: (context) {
          return Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Center(
                child: Text('Current Level: ${userLevels[user.level]}',
                  style: Styles.headerLarge)),
            ),
          ]);
        }));
  }
}
