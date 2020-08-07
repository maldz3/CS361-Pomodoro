import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
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

    Map<String, int> catTimes = { 'Home': 0, 'Work': 10, 'School': 10, 'Exercise': 5, 'Family': 2, 'Other': 1 };

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
          return Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text('Current Level: $title',
                    style: Styles.headerLarge)
                ),
                //catPercents(context, catTimes, total_time)])
                SizedBox(height: 30,),
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Row(children: [  
                    LinearPercentIndicator(
                      width: 100.0,
                      lineHeight: 8.0,
                      percent: (catTimes['Home'] / 10),
                      progressColor: Colors.red,
                    ),
                    Text('Home'),
                  ])
                ]),
                Column(children: [
                  Row(children: [
                    LinearPercentIndicator(
                      width: 100.0,
                      lineHeight: 8.0,
                      percent: (catTimes['Work'] / total_time),
                      progressColor: Colors.blue,
                    ),
                    Text('Work'),
                  ])
                ]),
                Column(children: [
                  Row(children: [
                    LinearPercentIndicator(
                      width: 100.0,
                      lineHeight: 8.0,
                      percent: (catTimes['School'] / total_time),
                      progressColor: Colors.yellow,
                    ),
                    Text('School'),
                  ])
                ]),
                Column(children: [
                  Row(children: [
                    LinearPercentIndicator(
                      width: 100.0,
                      lineHeight: 8.0,
                      percent: (catTimes['Exercise'] / total_time),
                      progressColor: Colors.green,
                    ),
                    Text('Exercise'),
                  ])
                ]),
                Column(children: [
                  Row(children: [
                    LinearPercentIndicator(
                      width: 100.0,
                      lineHeight: 8.0,
                      percent: (catTimes['Family'] / total_time),
                      progressColor: Colors.purple,
                    ),
                    Text('Family'),
                  ])
                ]),
                Column(children: [
                  Row(children: [
                    LinearPercentIndicator(
                      width: 100.0,
                      lineHeight: 8.0,
                      percent: (catTimes['Other'] / total_time),
                      progressColor: Colors.orange,
                    ),
                    Text('Other'),
                  ])
                ]),
              ]
            ),
          );
        }));
  }
}

// Widget catPercents(BuildContext context, Map<String, int> catTimes, int totalTime) {
//   print(catTimes);
//   catTimes.forEach((k,v){
//     return //Row(children: [
//       Text(k);
//       // LinearPercentIndicator(
//       //   width: 100.0,
//       //   lineHeight: 8.0,
//       //   percent: (v / totalTime),
//       //   progressColor: Colors.red,
//       // )
//     //]
//     //);
//   });
// }