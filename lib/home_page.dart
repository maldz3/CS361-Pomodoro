import 'package:flutter/material.dart';
import 'package:pomodoro/components/menu.dart';
import 'package:pomodoro/components/build_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MenuApp('Home Page'),
        drawer: BuildDrawer(),
        body: Center(
            child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/timer');
                },
                child: Text('Testing Routes'))));
  }
}
