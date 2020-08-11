import 'package:flutter/foundation.dart';
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
  final List<String> userLevels = [
    'Beginner',
    'Task Rabbit',
    'Task Master',
    'Pomo Beast'
  ];
  User user;
  int totalTime = 0;
  String title;
  Map<String, int> catTimes;
  Map<dynamic, dynamic> categoryColors;

  @override
  void initState() {
    super.initState();
    user = User.getInstance();

    catTimes = {
      'Home': 0,
      'Work': 0,
      'School': 0,
      'Exercise': 0,
      'Family': 0,
      'Other': 0
    };

    categoryColors = Map();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Stats'),
      drawer: BuildDrawer(),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: bodyChildren(context),
            ),
          ),
        );
      },
    );
  }

  List<Widget> bodyChildren(BuildContext context) {
    return [
      Center(child: Text('Current Level: $title', style: Styles.headerLarge)),
      SizedBox(height: 30),
      Container(
        padding: EdgeInsets.all(15.0),
        child: Wrap(
          spacing: 10.0,
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
          children: graphs(),
        ),
      ),
      SizedBox(height: 30),
      taskColumn(),
    ];
  }

  Widget graph(String cat, Color color) {
    double percent = catTimes[cat] / totalTime;
    return CircularPercentIndicator(
      radius: 150.0,
      lineWidth: 5.0,
      percent: percent,
      center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(cat), Text('${catTimes[cat]} / $totalTime')]),
      progressColor: color,
    );
  }

  List<Widget> graphs() {
    List<Widget> graphs = new List<Widget>();
    user.tasks.categories.forEach((element) {
      graphs.add(graph(element['id'], element['color']));
    });
    return graphs;
  }

  Widget progressIcon(Task t) {
    double progress = t.totalTime / t.goalTime;
    final double iconSize = 40.0;
    if (progress >= 1.0)
      return Icon(
        Icons.star,
        color: Colors.yellow,
        size: iconSize,
      );
    else if (progress >= 0.5)
      return Icon(
        Icons.star_half,
        color: Colors.yellow,
        size: iconSize,
      );
    else
      return Icon(
        Icons.star_border,
        size: iconSize,
      );
  }

  Widget taskColumn() {
    List<Widget> childos = new List<Widget>();

    childos.addAll([
      Center(
        child: Text(
          '~ Time By Task ~',
          style: Styles.headerLarge,
        ),
      ),
      SizedBox(height: 10),
    ]);

    if (user != null && user.tasks.list != null) {
      // destructive sort, will affect list app wide
      user.tasks.list.sort((b, a) => a.totalTime.compareTo(b.totalTime));

      for (Task t in user.tasks.list) {
        childos.add(
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ListTile(
                  //leading: // leading widget here //,
                  trailing: progressIcon(t),
                  title: Text(
                    t.name,
                  ),
                  subtitle:
                      Text("Worked on this task for ${t.totalTime} minutes."),
                ),
              ],
            ),
          ),
        );
      }
    } else {
      childos.add(Container(
        child: Text('You will need to add tasks before anything shows here!'),
      ));
    }

    return Column(
      children: childos,
    );
  }
}
