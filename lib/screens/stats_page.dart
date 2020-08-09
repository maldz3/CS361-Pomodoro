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
  List<String> userLevels = [
    'Beginner',
    'Task Rabbit',
    'Task Master',
    'Pomo Beast'
  ];
  User user;
  int totalTime = 0;
  String title;

  @override
  void initState() {
    super.initState();
    user = User.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> catTimes = {
      'Home': 0,
      'Work': 0,
      'School': 0,
      'Exercise': 0,
      'Family': 0,
      'Other': 0
    };
    final categoryColors = Map();
    user.tasks.categories.forEach((element) {
      categoryColors[element['id']] = element['color'];
    });

    // iterates through list of user tasks and increments times based on category
    if (user != null && user.tasks.list != null) {
      for (Task t in user.tasks.list) {
        String category = t.category.toString();
        if (t.totalTime > 0) {
          catTimes[category] += t.totalTime;
        }
      }
    }

    // iterates through category map and gets total overall time
    catTimes.forEach((k, v) => totalTime += v);

    // uses total_time to determine user level/title
    int index = totalTime ~/ 500;
    if (index > userLevels.length) {
      title = 'Pomo Beast';
    } else {
      title = userLevels[index];
    }

    Widget graphBuilder(String cat, Color color) {
      double percent = catTimes[cat] / totalTime;
      return CircularPercentIndicator(
        radius: 150.0,
        lineWidth: 5.0,
        percent: percent,
        center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(cat),
              Text('${catTimes[cat]} / $totalTime')
            ]),
        progressColor: color,
      );
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
                          style: Styles.headerLarge)),
                  //catPercents(context, catTimes, total_time)])
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    child: Wrap(
                      spacing: 10.0,
                      alignment: WrapAlignment.center,
                      direction: Axis.horizontal,
                      children: <Widget>[
                        graphBuilder('Exercise', categoryColors['Exercise']),
                        graphBuilder('Family', categoryColors['Family']),
                        graphBuilder('Home', categoryColors['Home']),
                        graphBuilder('School', categoryColors['School']),
                        graphBuilder('Work', categoryColors['Work']),
                        graphBuilder('Other', categoryColors['Other']),
                      ],
                    ),
                  )
                ]));
      }),
    );
  }
}
