import 'package:flutter/material.dart';
import 'package:pomodoro/our_components.dart';
import 'package:pomodoro/our_models.dart';
import 'package:pomodoro/styles.dart';

class StatsPage extends StatelessWidget {
  List<String> userLevels = ['Beginner', 'Task Master', 'Pomo Beast'];
  User user = User.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar('Stats'),
        drawer: BuildDrawer(),
        body: Builder(builder: (context) {
          return Column(children: <Widget>[
            Center(
                child: Text('Current Level: ${userLevels[user.level]}',
                    style: Styles.headerLarge)),
            SingleChildScrollView(child: Column())
          ]);
        }));
  }
}
