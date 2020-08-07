import 'package:flutter/material.dart';
import 'package:pomodoro/our_components.dart';
import 'package:pomodoro/our_models.dart';
import 'package:pomodoro/styles.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  List<String> userLevels = ['Beginner', 'Task Rabbit', 'Task Master', 'Pomo Beast'];
  User user;
  int total_time = 0;
  String title;

  @override
  void initState() {
    super.initState();
    user = User.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    int workTime, schoolTime, exerciseTime, homeTime, familyTime, otherTime;

    Map<String, int> catTimes = { 'Home': 0, 'Work': 0, 'Exercise': 0, 'Family': 0, 'Other': 0 };

    // iterates through list of user tasks and increments times based on category
    if(user != null && user.tasks.list != null) {
      for (Task t in user.tasks.list) {
        String category = t.category.toString();
        if (t.totalTime > 0) {
          catTimes[category] += t.totalTime;
        }
      }
    }

    // iterates through category map and gets total overall time
    catTimes.forEach((k,v) => total_time += v);
   
    // uses total_time to determine user level/title
    int index = total_time ~/ 500;
    if(index > userLevels.length) {
      title = 'Pomo Beast';
    } else {
      title = userLevels[index]; 
    }

    return Scaffold(
        appBar: CustomAppBar('Stats'),
        drawer: BuildDrawer(),
        body: Builder(builder: (context) {
          return Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Center(
                child: Text('Current Level: $title',
                  style: Styles.headerLarge)),
            ),
          ]);
        }));
  }
}
