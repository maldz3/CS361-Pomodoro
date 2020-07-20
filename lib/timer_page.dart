import 'package:flutter/material.dart';
import 'package:pomodoro/components/build_drawer.dart';
import 'package:pomodoro/components/app_bar.dart';
import 'package:pomodoro/models/user.dart';

class TimerPage extends StatefulWidget {
  final User user;
  final BuildDrawer buildDrawer;
  TimerPage(this.user, this.buildDrawer);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar('Timer', this.widget.user),
        drawer: this.widget.buildDrawer,
        body: Center(child: Text('Testing Routes')));
  }
}
