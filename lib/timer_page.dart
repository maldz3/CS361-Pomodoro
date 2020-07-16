import 'package:flutter/material.dart';
import 'package:pomodoro/components/build_drawer.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Timer Page')),
        drawer: BuildDrawer(),
        body: Center(child: Text('Testing Routes')));
  }
}
